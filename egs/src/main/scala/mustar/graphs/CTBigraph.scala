package mustar
package graphs

import mustar.util.Timed

object CTBigraph {

  type Vertex = Either[SituatedTuple, Constant]
  case class EdgeLabel(relName: RelationName, index: Int) {
    override def toString: String = s"(${relName.name}, $index)"
  }
  type CTBigraph = Graph[Vertex, EdgeLabel]

  def apply(problem: Problem): CTBigraph = Timed {
    val tuples = for ((relName, relation) <- problem.inputRelations.toSet;
                      tuple <- relation.tuples)
                 yield SituatedTuple(relName, tuple)
    val constants = problem.domains.flatMap(_._2).toSet
    val vertices = tuples.map(tuple => Left(tuple)) ++ constants.map(c => Right(c))
    val edges = for (st @ SituatedTuple(relName, tuple) <- tuples;
                     (c, i) <- tuple.fields.zipWithIndex)
                yield Edge(Left(st), EdgeLabel(relName, i), Right(c))
    Graph(vertices, edges)
  }

}
