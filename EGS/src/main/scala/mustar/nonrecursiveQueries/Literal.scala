package mustar
package nonrecursiveQueries

case class Literal(relationName: RelationName, fields: IndexedSeq[Variable]) {
  require(relationName.schema == fields.map(_.domain))
  def schema: IndexedSeq[Domain] = relationName.schema
  override def toString: String = s"${relationName.name}(${fields.mkString(", ")})"
}