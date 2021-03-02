package mustar
package graphs

import mustar.util.Timed

object ConstantGraph {

  type ConstantGraph = Graph[Constant, EdgeLabel]

  def apply(problem: Problem): ConstantGraph = {
    val vertices: Set[Constant] = problem.domains.flatMap(_._2).toSet
    val edges = for ((relName, relation) <- problem.inputRelations;
                     t <- relation.tuples;
                     i <- t.fields.indices;
                     j <- t.fields.indices;
                     label = EdgeLabel(relName, i, j))
                yield Edge(t(i), label, t(j))
    Graph(vertices, edges.toSet)
  }

  case class EdgeLabel(relName: RelationName, srcIndex: Int, sinkIndex: Int) {
    override def toString: String = s"(${relName.name}, $srcIndex, $sinkIndex)"
  }

  def allWitnessTuples(
                        inputRelations: Map[RelationName, Relation],
                        edge: Edge[Constant, EdgeLabel]
                      ): Set[DTuple] = Timed {
    val Edge(src, EdgeLabel(relName, srcIndex, sinkIndex), sink) = edge
    val inputRelation = inputRelations(relName)

    val outputTuples1 = inputRelation.tuples
    val outputTuples2 = outputTuples1.filter(t => t(srcIndex) == src)
    val outputTuples3 = outputTuples2.filter(t => t(sinkIndex) == sink)

    outputTuples3
  }

  def allWitnessPaths(
                       inputRelations: Map[RelationName, Relation],
                       path: Path[Constant, EdgeLabel]
                     ): Set[DTuple] = {
    var ans = Set(DTuple())
    for (edge <- path.edges) {
      ans = for (t1 <- ans; t2 <- allWitnessTuples(inputRelations, edge))
            yield t1 ++ t2
    }
    ans
  }

}
