package mustar
package nonrecursiveQueries

case class UCQ(outputRelName: RelationName, queries: Set[Rule]) {
  require(queries.forall(_.outputRelName == outputRelName))

  def ++(that: UCQ): UCQ = {
    require(this.outputRelName == that.outputRelName)
    UCQ(outputRelName, this.queries ++ that.queries)
  }

  def +(rule: Rule): UCQ = {
    require(this.outputRelName == rule.outputRelName)
    UCQ(outputRelName, this.queries + rule)
  }

  def apply(inputRelations: Map[RelationName, Relation]): Relation = {
    queries.foldLeft(Relation(outputRelName.schema, Set()))(_ ++ _(inputRelations))
  }
}

object UCQ {
  def apply(outputRelName: RelationName): UCQ = UCQ(outputRelName, Set())
}