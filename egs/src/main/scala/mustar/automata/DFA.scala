package mustar
package automata

import mustar.nonrecursiveQueries.SPJSymbol
import mustar.util.Logging

case class DFA[State](
                       states: Set[State],
                       alphabet: Set[SPJSymbol],
                       transitions: Map[State, Map[SPJSymbol, State]],
                       initialState: State,
                       finalStates: Set[State]
                     ) {

  require(states.forall(q => alphabet.forall(a => states.contains(transitions(q)(a)))))
  require(states.contains(initialState))
  require(finalStates.subsetOf(states))

  def accepts(w: Seq[SPJSymbol]): Boolean = {
    finalStates.contains(w.foldLeft(initialState)({ case (q, a) => transitions(q)(a) }))
  }

  def transform[State2](f: State => State2): DFA[State2] = {
    val newTransitions = transitions.map({ case (q, tq) => f(q) -> tq.transform({ case (_, tqa) => f(tqa) }) })
    DFA(states.map(f), alphabet, newTransitions, f(initialState), finalStates.map(f))
  }

  def anonymize(): DFA[Int] = {
    val newName = states.zipWithIndex.toMap
    this.transform(newName)
  }

  def pruneReachable(): DFA[State] = {
    val newStates = collection.mutable.Set[State](initialState)
    val queue = collection.mutable.Queue[State](initialState)
    while (queue.nonEmpty) {
      val q = queue.dequeue()
      for (qPrime <- transitions(q).values if !newStates.contains(qPrime)) {
        newStates += qPrime
        queue += qPrime
      }
    }
    val newTransitions = transitions.filter({ case (q, _) => newStates.contains(q) })
    DFA(newStates.toSet, alphabet, newTransitions, initialState, finalStates & newStates)
  }

  lazy val liveStates: Map[State, Vector[SPJSymbol]] = {
    val ans = collection.mutable.Map[State, Vector[SPJSymbol]]()
    ans ++= this.finalStates.map(q => q -> Vector())
    var changed = true
    while (changed) {
      changed = false
      for (q1 <- states; a <- alphabet) {
        val q2 = transitions(q1)(a)
        if (ans.contains(q2) && !ans.contains(q1)) {
          ans += (q1 -> (a +: ans(q2)))
          changed = true
        }
      }
    }
    ans.toMap
  }

  def product[State2](that: DFA[State2], isFinal: (State, State2) => Boolean): DFA[(State, State2)] = {
    require(this.alphabet == that.alphabet)

    val product = this.states.map(q1 => {
      q1 -> that.states.map(q2 => q2 -> (q1, q2)).toMap
    }).toMap
    val newStates = product.values.flatMap(_.values).toSet
    val newDelta = newStates.map({ case q @ (q1, q2) =>
      q -> alphabet.map(a => {
        val q1Prime = this.transitions(q1)(a)
        val q2Prime = that.transitions(q2)(a)
        a -> product(q1Prime)(q2Prime)
      }).toMap
    }).toMap
    val newInitialState = product(this.initialState)(that.initialState)
    val newFinalStates = newStates.filter({ case (q1, q2) => isFinal(q1, q2) })

    DFA(newStates, alphabet, newDelta, newInitialState, newFinalStates)
  }

  def ||[State2](that: DFA[State2]): DFA[(State, State2)] = {
    product(that, (q1, q2) => this.finalStates.contains(q1) || that.finalStates.contains(q2))
  }
  def &&[State2](that: DFA[State2]): DFA[(State, State2)] = {
    product(that, (q1, q2) => this.finalStates.contains(q1) && that.finalStates.contains(q2))
  }
  def complement: DFA[State] = DFA(states, alphabet, transitions, initialState, states -- finalStates)

  def -[State2](that: DFA[State2]): DFA[(State, State2)] = this && that.complement

  def witness: Option[Vector[SPJSymbol]] = {
    val witnessMap = collection.mutable.Map(initialState -> Vector[SPJSymbol]())
    val queue = collection.mutable.Queue(initialState)

    while (queue.nonEmpty) {
      val q = queue.dequeue()
      assert(witnessMap.contains(q))
      for (a <- alphabet) {
        val qPrime = transitions(q)(a)
        if (!witnessMap.contains(qPrime)) {
          witnessMap(qPrime) = witnessMap(q) :+ a
          queue.enqueue(qPrime)
        }
      }
    }

    finalStates.find(witnessMap.contains).map(witnessMap)
  }

  override def toString: String = {
    val lf = scala.util.Properties.lineSeparator

    val maxQLen = states.map(_.toString.length).max
    val maxAlphaLen = alphabet.map(_.toString.length).max

    val alphaStr = for (a <- alphabet)
                   yield a.toString

    val deltaStr = for ((q, dq) <- transitions;
                        qStr = q.toString.padTo(maxQLen, ' ');
                        (a, dqa) <- dq;
                        aStr = s"--($a)-->".padTo(maxAlphaLen + 7, ' '))
                   yield s"$qStr $aStr $dqa"

    s"""DFA(
       |  states=${states.mkString("{", ", ", "}")},
       |  alphabet=${alphaStr.map(s => "    " + s).mkString(lf, "," + lf, "")},
       |  transitions=(${deltaStr.map(s => "    " + s).mkString(lf, "," + lf, "")}
       |  ),
       |  initialState=$initialState,
       |  finalStates=${finalStates.mkString("{", ", ", "}")}
       |)""".stripMargin
  }

}

object DFA {

  def empty(alphabet: Set[SPJSymbol]): DFA[Int] = {
    val transitions = Map(0 -> alphabet.map(a => a -> 0).toMap)
    DFA(Set(0), alphabet, transitions, 0, Set())
  }

  def inequivalanceWitness[State1, State2](
                                            m1: DFA[State1],
                                            m2: DFA[State2]
                                          ): Option[Vector[SPJSymbol]] = {
    val wm1m2 = (m1 - m2).witness
    if (wm1m2.nonEmpty) return wm1m2
    (m2 - m1).witness
  }

}
