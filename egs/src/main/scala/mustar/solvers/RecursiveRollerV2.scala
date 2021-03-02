package mustar
package solvers

import mustar.automata.{Accept, DFA, EvalResult, IllTypedResult, Learner, LstarV2, Reject, StateV2}
import mustar.nonrecursiveQueries.SymbolExtractor.Disjunct
import mustar.nonrecursiveQueries.{Rule, SPJSymbol, SymbolExtractor, UCQ}
import mustar.util.{Logging, Timed}

object RecursiveRollerV2 {

  def learnDFA(
                inputRelations: Map[RelationName, Relation],
                outputRelation: Relation,
                ucq: UCQ
              ): DFA[Int] = Timed {

    val positiveWitnesses = RecursiveRoller.getPositiveWitnesses(inputRelations, ucq)
    val alphabet = positiveWitnesses.values.flatMap(_._3).toSet

    Logging.infoOut("// Printing SPJ symbols:")
    alphabet.foreach(a => Logging.infoOut(s"// $a"))
    Logging.infoOut("")

    Logging.info("Printing positive witnesses:")
    for ((t, d) <- positiveWitnesses) {
      Logging.info(s"  $t:")
      Logging.info(s"  ${d._2.permutedRule}")
      d._3.foreach(a => Logging.info(s"    $a"))
      Logging.info("")
    }

    type Word = Vector[SPJSymbol]
    type OptTuple = Option[DTuple]
    var initialStrings = Set[Word]()

    // In the target DFA, a string should be accepted iff it is well-typed and produces all good tuples

    def eval(w: Seq[SPJSymbol]): EvalResult = Timed {
      var acc = Set(DTuple())
      for (a @ SPJSymbol(precondition, relName, _, _) <- w) {
        if (acc.exists(_.schema != precondition)) {
          return IllTypedResult
        }
        acc = a(acc)(inputRelations(relName))
      }
      if (acc.subsetOf(outputRelation.tuples)) Accept(acc) else Reject(acc)
    }

    for ((_, (_, _, w)) <- positiveWitnesses) {
      eval(w) match {
        case Accept(_) => ()
        case ew @ _ =>
          //noinspection NameBooleanParameters
          assert(false, s"Evaluation oracle fails to recognize positive word $w ($ew)")
      }
    }

    def fixpoint[State](automaton: DFA[State]): Map[State, Map[OptTuple, Word]] = Timed {
      val DFA(states, _, transitions, initialState, finalStates) = automaton
      val generatedTuples = states.map(q => q -> collection.mutable.Map[OptTuple, Word]()).toMap
      val queue = collection.mutable.Queue[(State, OptTuple, Word)]()
      def recordTupleBirth(q: State, ot: OptTuple, w: Word): Unit = {
        if (!generatedTuples(q).contains(ot)) {
          generatedTuples(q) += ot -> w
          queue.enqueue((q, ot, w))
        }
      }

      recordTupleBirth(initialState, Some(DTuple()), Vector())
      while (queue.nonEmpty) {
        val (q1, ot, w) = queue.dequeue()
        for (a @ SPJSymbol(_, relName, _, _) <- alphabet) {
          val wa = w :+ a
          val q2 = transitions(q1)(a)
          ot match {
            case Some(t) if t.schema == a.precondition =>
              for (tRes <- a(t)(inputRelations(relName))) {
                recordTupleBirth(q2, Some(tRes), wa)
              }

            case Some(_) | None =>
              recordTupleBirth(q2, None, wa)
          }
        }
      }

      for ((q, otws) <- generatedTuples)
      yield q -> otws.toMap
    }

    def equiv[State](automaton: DFA[State]): Option[Word] = Timed {
      val fp = fixpoint(automaton)

      for (w <- initialStrings) {
        assert(automaton.accepts(w))
      }

      for ((q, otws) <- fp if automaton.finalStates.contains(q)) {
        for ((ot, ws) <- otws) {
          ot match {
            case Some(t) if !outputRelation.tuples.contains(t) => return Some(ws)
            case None => return Some(ws)
            case _ => ()
          }
        }
      }

      None
    }

    var unexplainedTuples = outputRelation.tuples
    var dfa = DFA.empty(alphabet)
    while (unexplainedTuples.nonEmpty) {
      val t = unexplainedTuples.minBy(t => positiveWitnesses(t)._3.length)
      val (_, _, w) = positiveWitnesses(t)
      initialStrings = initialStrings + w
      dfa = LstarV2(alphabet, initialStrings, eval, (automaton: DFA[StateV2]) => equiv(automaton)).anonymize()
      val genTuples = fixpoint(dfa).filter({ case (q, _) => dfa.finalStates.contains(q) })
                                   .flatMap(_._2.keys).map(_.get).toSet
      unexplainedTuples = outputRelation.tuples -- genTuples
    }

    Logging.info(dfa)
    dfa

    /* val ans = LstarV2(alphabet, initialStrings, eval, (automaton: DFA[DFAState]) => equiv(automaton))
    Logging.info(ans.anonymize())
    // toDatalog(ucq, ans)
    ans */
  }

  def toDatalog[State](ucq: UCQ, dfa: DFA[State]): DFA[State] = {
    val RelationName(outputRelName, outputSchema) = ucq.outputRelName
    val DFA(states, alphabet, transitions, initialState, finalStates) = dfa
    val predicates = dfa.liveStates.keySet
    assert(finalStates.subsetOf(predicates))

    val liveSymbols = (for (q <- predicates)
      yield q -> alphabet.filter(a => predicates.contains(transitions(q)(a)))).toMap
    val predicateSchemas = (for (q <- predicates)
      yield q -> {
        val ans1 = liveSymbols(q).map(_.precondition)
        val ans2 = if (finalStates.contains(q)) ans1 + outputSchema else ans1
        assert(ans2.size == 1, s"Accepting state associated with multiple schemas $ans2")
        ans2.head
      }).toMap

    Logging.info("Passing here!")
    dfa
  }

}
