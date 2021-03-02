package mustar
package automata

import mustar.automata.Learner.{epsilon, postcondition}
import mustar.nonrecursiveQueries.SPJSymbol
import mustar.util.{Logging, Timed}

sealed abstract class StateV1
case class WellTypedState(accessString: Seq[SPJSymbol], schema: IndexedSeq[Domain]) extends StateV1
case object IllTypedState extends StateV1

object LstarV1 extends Learner[StateV1] {

  override def apply(
                      alphabet: Set[SPJSymbol],
                      initialStrings: Set[Vector[SPJSymbol]],
                      eval: Seq[SPJSymbol] => EvalResult,
                      equiv: DFA[StateV1] => Option[Seq[SPJSymbol]]
                    ): DFA[StateV1] = Timed {
    Logging.info(s"alphabet.size = ${alphabet.size}")

    val _evalMemo = collection.mutable.Map[Seq[SPJSymbol], EvalResult]()
    def _eval(w: Seq[SPJSymbol]): EvalResult = _evalMemo.getOrElseUpdate(w, eval(w))

    var Q = Set(epsilon) // States, or accessing prefixes
                         // All strings are well-typed, and pairwise distinguishable by T
    var T = Set(epsilon) | alphabet.map(a => Vector(a)) // Distinguishing suffixes

    // Two access words w1, w2 are T-equivalent if for all suffixes w3 in T, eval(w1 w3) = eval(w2 w3)
    def Tequiv(w1: Seq[SPJSymbol], w2: Seq[SPJSymbol]): Boolean = {
      T.forall(w3 => _eval(w1 ++ w3).isAccepted == _eval(w2 ++ w3).isAccepted)
    }

    // Returns a state wPrime in Q which is T-equivalent to w
    // findRepresentative of ill-typed string is bad-typed state
    def findRepresentative(w: Seq[SPJSymbol]): Option[Vector[SPJSymbol]] = {
      val spw @ Some(_) = postcondition(w)
      Q.find(wPrime => spw == postcondition(wPrime) && Tequiv(w, wPrime))
    }

    // Returns a new access string q1 + (a,) iff Q is not closed
    // In this case, q1 in Q and a in alphabet, and q1 + (a,) is T-inequivalent to every string q2 already in Q
    // Leaves Q unchanged
    def findNewState(): Option[Vector[SPJSymbol]] = Timed("Lstar.findNewState()") {
      for (q1 <- Q; a <- alphabet if postcondition(q1 :+ a).nonEmpty) {
        val q1a = q1 :+ a
        if (findRepresentative(q1a).isEmpty) {
          findRepresentative(q1a)
          return Some(q1a)
        }
      }
      None
    }

    def buildAutomaton: DFA[StateV1] = Timed("Lstar.buildAutomaton()") {
      val wellTypedStates = Q.map(w => w -> WellTypedState(w, postcondition(w).get)).toMap
      val states = wellTypedStates.values.map(q => q: StateV1).toSet + IllTypedState

      val transitions1 = for ((_, q @ WellTypedState(w, wPost)) <- wellTypedStates)
                         yield (q: StateV1) -> {
                           val tq = for (a <- alphabet)
                                    yield a -> (if (wPost == a.precondition) {
                                                  wellTypedStates(findRepresentative(w :+ a).get): StateV1
                                                } else IllTypedState: StateV1)
                           tq.toMap
                         }
      val transitions2 = (IllTypedState: StateV1) -> alphabet.map(a => a -> (IllTypedState: StateV1)).toMap
      val transitions = transitions1 + transitions2

      val initialState = wellTypedStates(epsilon)
      val finalStates = Q.filter(w => _eval(w).isAccepted).map(w => wellTypedStates(w): StateV1)

      DFA(states, alphabet, transitions, initialState, finalStates)
    }

    // q0 = epsilon
    // eval(q0 w1 w2 w3 ... wn) = eval(w), viz. actual membership query for w. By definition, this is correct.
    // eval(   q1 w2 w3 ... wn) /* Say this is correct. */
    // eval(      q2 w3 ... wn) /* Say this is incorrect. */
    // eval(                qn) = A(w), viz. whether the hypothesis automaton A accepted w. We know that this is
    //                                       incorrect.
    // Claim: "w3 ... wn" distinguishes between (q1 w2) and q2.
    // Therefore, add "w3 w4 ... wn" to T

    // Given a counter-example string, processes it into a new discriminator to be added to T
    def findNewDiscriminator(w: Vector[SPJSymbol]): Vector[SPJSymbol] = Timed("Lstar.findNewDiscriminator()") {
      var qPre: IndexedSeq[SPJSymbol] = epsilon
      var wSuff = w
      require(postcondition(qPre ++ wSuff).nonEmpty)

      while (_eval(qPre ++ wSuff) == _eval(w)) {
        val nextQPre = findRepresentative(qPre :+ wSuff.head).get
        qPre = nextQPre
        wSuff = wSuff.tail
        assert(postcondition(qPre ++ wSuff).nonEmpty)
      }
      assert(wSuff != w)

      wSuff
    }

    while (true) {
      Logging.info(s"T.size = ${T.size}")

      Timed("Lstar.closeAutomaton()") {
        var changed = true
        while (changed) {
          changed = false
          Logging.info(s"Q.size = ${Q.size}")
          val optNewState = findNewState()
          optNewState match {
            case Some(wPre) =>
              Logging.info("Found new state with access string:")
              for (a <- wPre) Logging.info(s"  $a")
              Q = Q + wPre
              changed = true
            case None => ()
          }
        }
      }

      val automaton = buildAutomaton
      val anonymousAutomaton = automaton.anonymize()
      Logging.info(anonymousAutomaton)
      Logging.info(s"Live states: ${anonymousAutomaton.liveStates.keySet.mkString("{", ", ", "}")}")

      equiv(automaton) match {
        case Some(cexW) =>
          val currResult = if (automaton.accepts(cexW)) "accepts" else "rejects"
          Logging.info(s"Automaton mistakenly $currResult counter-example word:")
          cexW.foreach(a => Logging.info(s"  $a"))
          val newDiscriminatingSuffix = findNewDiscriminator(cexW.toVector)
          T = T + newDiscriminatingSuffix
          Logging.info(s"Discovered new discriminating suffix:")
          newDiscriminatingSuffix.foreach(a => Logging.info(s"  $a"))

        case None => return automaton
      }
    }

    throw new Exception("Unreachable code!")
  }

}
