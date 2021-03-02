package mustar
package graphs

import mustar.util.{Logging, Timed}

case class Edge[V, L](src: V, label: L, sink: V)

case class Path[V, L] private (src: V, edges: IndexedSeq[Edge[V, L]]) {

  val end: V = if (edges.nonEmpty) edges.last.sink else src
  val length: Int = edges.length

  def ++(that: Path[V, L]): Path[V, L] = {
    require(this.end == that.src)
    Path(this.src, this.edges ++ that.edges)
  }

  def :+(edge: Edge[V, L]): Path[V, L] = {
    require(this.end == edge.src)
    Path(this.src, this.edges :+ edge)
  }

  override def toString: String = {
    this.src.toString + edges.map(edge => s" --${edge.label}--> ${edge.sink}").mkString("")
  }

}

object Path {
  def apply[V, L](src: V): Path[V, L] = Path(src, Vector[Edge[V, L]]())
}

case class Graph[V, L](vertices: Set[V], edges: Set[Edge[V, L]]) {

  for (edge <- edges) {
    require(vertices.contains(edge.src), s"Edge $edge has unknown source. Vertices = $vertices.")
    require(vertices.contains(edge.sink), s"Edge $edge has unknown sink. Vertices = $vertices.")
  }

  def print(printer: (=> String) => Unit): Unit = {
    printer("Graph {")
    printer(s"  Vertices = {${vertices.map(_.toString).toVector.sorted.mkString(", ")}}")

    printer("  Edges:")
    val maxEdgeSrcLen = edges.map(_.src.toString.length).max
    val maxEdgeLabelLen = edges.map(_.label.toString.length).max
    val edgeStrs = for (edge <- edges)
                   yield {
                     val srcStr = edge.src.toString.padTo(maxEdgeSrcLen, ' ')
                     val labelStr = s"--${edge.label}-->".padTo(maxEdgeLabelLen + 5, ' ')
                     val sinkStr = edge.sink.toString
                     s"$srcStr $labelStr $sinkStr"
                   }
    for (edgeStr <- edgeStrs.toVector.sorted) {
      printer(s"    $edgeStr")
    }

    printer("}")
  }

  override def toString: String = {
    val builder = new collection.mutable.StringBuilder()
    val nl = System.lineSeparator()
    print(str => builder.append(str.toString + nl))
    builder.toString()
  }

  lazy val edgesFromVertex: Map[V, Set[Edge[V, L]]] = Timed {
    val ans = vertices.map(v => v -> collection.mutable.Set[Edge[V, L]]()).toMap
    edges.foreach(edge => ans(edge.src).add(edge))
    ans.transform({ case (_, es) => es.toSet })
  }

  lazy val edgesToVertex: Map[V, Set[Edge[V, L]]] = Timed {
    val ans = vertices.map(v => v -> collection.mutable.Set[Edge[V, L]]()).toMap
    edges.foreach(edge => ans(edge.sink).add(edge))
    ans.transform({ case (_, es) => es.toSet })
  }

  private val _distanceMatrix: collection.mutable.Map[V, Map[V, Int]] = collection.mutable.Map()
  def distanceMatrix(u: V)(v: V): Option[Int] = {
    if (!_distanceMatrix.contains(u)) {
      val mu = collection.mutable.Map[V, Int](u -> 0)
      val queue = collection.mutable.Queue[V](u)
      while (queue.nonEmpty) {
        val v = queue.dequeue()
        assert(mu.contains(v))
        for (edge <- edgesFromVertex(v); w = edge.sink if !mu.contains(w)) {
          mu(w) = mu(v) + 1
          queue.enqueue(w)
        }
      }
      _distanceMatrix(u) = mu.toMap

      if ((_distanceMatrix.size & (_distanceMatrix.size - 1)) == 0) {
        Logging.info(s"_distanceMatrix.size = ${_distanceMatrix.size}")
      }
    }
    assert(_distanceMatrix.contains(u))
    _distanceMatrix(u).get(v)
  }

}