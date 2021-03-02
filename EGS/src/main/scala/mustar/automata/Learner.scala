package mustar
package automata

import mustar.nonrecursiveQueries.SPJSymbol

abstract class Learner[State] {

  def apply(
             alphabet: Set[SPJSymbol],
             initialStrings: Set[Vector[SPJSymbol]],
             eval: Seq[SPJSymbol] => EvalResult,
             equiv: DFA[State] => Option[Seq[SPJSymbol]]
           ): DFA[State]

}

object Learner {
  val epsilon: Vector[SPJSymbol] = Vector()
  type Schema = IndexedSeq[Domain]
  def postcondition(w: Seq[SPJSymbol]): Option[Schema] = {
    val opc0: Option[Schema] = Some(Vector())
    w.foldLeft(opc0)({ case (opc, a) => opc match {
      case Some(pc) if pc == a.precondition => Some(a.postcondition)
      case Some(_) | None => None
    }})
  }
}

sealed abstract class EvalResult(val isAccepted: Boolean)
sealed abstract class WellTypedResult(isAccepted: Boolean) extends EvalResult(isAccepted) {
  val tuples: Set[DTuple]
}
case class Accept(tuples: Set[DTuple]) extends WellTypedResult(true)
case class Reject(tuples: Set[DTuple]) extends WellTypedResult(false)
case object IllTypedResult extends EvalResult(false)