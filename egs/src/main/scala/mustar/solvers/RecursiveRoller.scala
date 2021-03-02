package mustar
package solvers

import mustar.automata.{Accept, DFA, EvalResult, IllTypedResult, Learner, LstarV2, Reject, StateV2}
import mustar.nonrecursiveQueries.SymbolExtractor.Disjunct
import mustar.nonrecursiveQueries.{Rule, SPJSymbol, SymbolExtractor, UCQ}
import mustar.util.{Logging, Timed}

object RecursiveRoller {

  def getPositiveWitnesses(
                            inputRelations: Map[RelationName, Relation],
                            ucq: UCQ
                          ): Map[DTuple, (Rule, Disjunct, Vector[SPJSymbol])] = {
    val ruleSymbols = SymbolExtractor(ucq)
    assert(ruleSymbols.keySet == ucq.queries)
    for ((rule, disjunct) <- ruleSymbols; t <- rule(inputRelations).tuples)
    yield t -> (rule, disjunct, disjunct.symbols)
  }

  def learnDFA(
                inputRelations: Map[RelationName, Relation],
                outputRelation: Relation,
                ucq: UCQ
              ): DFA[StateV2] = Timed {

    val positiveWitnesses = getPositiveWitnesses(inputRelations, ucq)
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

    val initialStrings = positiveWitnesses.values.map(_._3).toSet

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

    def equiv[State](automaton: DFA[State]): Option[Vector[SPJSymbol]] = Timed {
      val DFA(states, _, transitions, initialState, finalStates) = automaton

      type Word = Vector[SPJSymbol]
      type OptTuple = Option[DTuple]
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
                if (finalStates.contains(q2) && !outputRelation.tuples.contains(tRes)) {
                  return Some(wa) // Automaton produces an undesirable tuple
                }
              }

            case Some(_) | None =>
              recordTupleBirth(q2, None, wa)
              if (finalStates.contains(q2)) {
                return Some(wa) // Automaton accepts an ill-typed string
              }
          }
        }
      }

      val allGeneratedTuples = for (q <- automaton.finalStates; (ot, _) <- generatedTuples(q)) yield ot.get
      val unproducedTuples = outputRelation.tuples -- allGeneratedTuples
      if (unproducedTuples.nonEmpty) {
        val shortestUnproducedTuple = unproducedTuples.minBy(t => positiveWitnesses(t)._3.size)
        Some(positiveWitnesses(shortestUnproducedTuple)._3)
      } else None
    }

    type DFAState = StateV2
    val ans = LstarV2(alphabet, initialStrings, eval, (automaton: DFA[DFAState]) => equiv(automaton))
    Logging.info(ans.anonymize())
    // toDatalog(ucq, ans)
    ans
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
