package mustar
package automata

import mustar.automata.Learner.epsilon
import mustar.nonrecursiveQueries.SPJSymbol
import mustar.util.{Logging, Timed}

sealed abstract class StateV2
case class PrefixState(w: Vector[SPJSymbol]) extends StateV2
case object FailState extends StateV2

object LstarV2 extends Learner[StateV2] {

  override def apply(
                      alphabet: Set[SPJSymbol],
                      initialStrings: Set[Vector[SPJSymbol]],
                      eval: Seq[SPJSymbol] => EvalResult,
                      equiv: DFA[StateV2] => Option[Seq[SPJSymbol]]
                    ): DFA[StateV2] = Timed {

    Logging.info(s"alphabet.size = ${alphabet.size}")
    Logging.info(s"initialStrings.size = ${initialStrings.size}")

    val _evalMemo = collection.mutable.Map[Seq[SPJSymbol], EvalResult]()
    def _eval(w: Seq[SPJSymbol]): EvalResult = _evalMemo.getOrElseUpdate(w, eval(w))

    val prefixes = for (w <- initialStrings; i <- 0 to w.length) yield w.dropRight(i)
    var T = Set(epsilon) // for (w <- initialStrings; i <- 0 to w.length) yield w.drop(i)
    def Tequiv(w1: Seq[SPJSymbol], w2: Seq[SPJSymbol]): Boolean = {
      T.forall(w3 => _eval(w1 ++ w3).isAccepted == _eval(w2 ++ w3).isAccepted)
    }

    def buildAutomaton(): DFA[StateV2] = {
      while (true){
        val equivClasses = collection.mutable.Set[collection.mutable.Set[Vector[SPJSymbol]]]()
        for (w <- prefixes) {
          equivClasses.find(ws => Tequiv(w, ws.head)) match {
            case Some(ws) => ws += w
            case None => equivClasses += collection.mutable.Set(w)
          }
        }
        val equivMap = (for (ws <- equivClasses; w <- ws) yield w -> ws).toMap
        def normalize(w: Vector[SPJSymbol]): Option[Vector[SPJSymbol]] = {
          val optWPre = if (prefixes.contains(w)) Some(w) else prefixes.find(wPre => Tequiv(w, wPre))
          optWPre.map(equivMap).map(_.head)
        }

        val prefixStates = equivClasses.map(ws => PrefixState(ws.head)).toSet
        val states = prefixStates.map(q => q: StateV2) + FailState

        var rightCongruence = true
        val t1 = for (q1 @ PrefixState(w1) <- prefixStates if rightCongruence)
                 yield (q1: StateV2) -> {
                   val equivClass = equivMap(w1)
                   (for (a <- alphabet)
                    yield a -> {
                      val cexs = for (w2 <- equivClass; w3 <- T;
                                      w1aw3 = (w1 :+ a) ++ w3; w2aw3 = (w2 :+ a) ++ w3
                                      if _eval(w1aw3).isAccepted != _eval(w2aw3).isAccepted)
                                 yield (w2, w3)
                      if (cexs.isEmpty) {
                        val optTarget = normalize(w1 :+ a)
                        optTarget match {
                          case Some(w3) => PrefixState(equivMap(w3).head): StateV2
                          case None => FailState: StateV2
                        }
                      } else {
                        val (_, w3) = cexs.head
                        T = T + (a +: w3)
                        rightCongruence = false
                        null
                      }
                    }).toMap
                 }
        val t2 = (FailState: StateV2) -> alphabet.map(a => a -> FailState).toMap
        val transitions = (t1 + t2).toMap

        val initialState = PrefixState(normalize(epsilon).get)
        val finalStates = initialStrings.map(w => PrefixState(normalize(w).get): StateV2)
        if (rightCongruence) {
          return DFA(states, alphabet, transitions, initialState, finalStates)
        }
      }

      throw new UnsupportedOperationException("Unreachable code!")
    }

    while (true) {
      val automaton = buildAutomaton()
      equiv(automaton) match {
        case Some(cex) =>
          (0 to cex.length).foreach(i => T = T ++ Set(cex.drop(i).toVector))
        case None =>
          Logging.info(s"Number of prefixes: ${prefixes.size}, number of states: ${automaton.states.size}")
          return automaton
      }
    }

    throw new UnsupportedOperationException("Unreachable code!")

  }

}
