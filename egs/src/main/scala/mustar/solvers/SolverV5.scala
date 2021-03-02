package mustar
package solvers

import mustar.graphs.ConstantGraph.EdgeLabel
import mustar.graphs.Graph
import mustar.nonrecursiveQueries.SPJ
import mustar.util.{Logging, Timed}

class SolverV5(problem: Problem) extends AbstractSolver(problem) {

  def solveTuple(st: SituatedTuple): SPJ = {
    val SituatedTuple(outputRelName, currTuple) = st
    val outputRelation = problem.outputRelations(outputRelName)

    require(outputRelName.schema == outputRelation.schema)
    require(outputRelation.schema == currTuple.schema)
    require(outputRelation.contains(currTuple))

    var ctx = Set[SituatedTuple]()
    for (i <- currTuple.fields.indices) {
      val ci = currTuple(i)
      val currTupleSlice = currTuple.slice(0, i + 1)
      val orni = RelationName(outputRelName.name + s"$i", outputRelName.schema.slice(0, i + 1))
      val outputRelationSlice = outputRelation.slice(0, i + 1)
      val explanations = enumSPJs(orni, outputRelationSlice, currTupleSlice, ci, ctx)
      ctx = explanations.head
      Logging.info(s"  Explaining indices [0--$i] using $ctx")
    }

    val ans = contextToSPJ(outputRelName, currTuple, ctx)
    val ai = ans(problem.inputRelations)
    assert(ai.contains(currTuple))
    assert(ai.subsetOf(outputRelation))
    ans
  }

  def contextToSPJ(outputRelName: RelationName, currTuple: DTuple, ctx: EnumerationContext): SPJ = {
    val ctxVector = ctx.toVector.sortBy(st => (st.relName.toString, st.tuple.toString))
    val joinExpr = ctxVector.map(_.relName)
    val sourceTuple = ctxVector.map(_.tuple).foldLeft(DTuple())(_ ++ _)
    SPJ(outputRelName, joinExpr, sourceTuple, currTuple)
  }

  def enumSPJs(
                 orni: RelationName,
                 outputRelationSlice: Relation,
                 currTupleSlice: DTuple,
                 targetConstant: Constant,
                 prevCtx: EnumerationContext,
               ): LazyList[EnumerationContext] = {
    val Graph(vertices, _) = constantGraph

    require(vertices.contains(targetConstant), s"Unrecognized constant $targetConstant. Vertices = $vertices.")

    Logging.info(s"Listing paths from $targetConstant")

    val numPossibleOutputTuples = orni.schema.map(problem.domains).map(_.size).product
    val numPossibleBadOutputTuples = numPossibleOutputTuples - outputRelationSlice.numTuples
    Logging.info(s"numPossibleOutputTuples: $numPossibleOutputTuples")
    Logging.info(s"numPossibleBadOutputTuples: $numPossibleBadOutputTuples")

    case class QueueElement(ctx: EnumerationContext, parent: Option[QueueElement]) {
      def size: Int = ctx.size
      def ends: Set[Constant] = ctx.flatMap(_.tuple.fields)
      def spj: SPJ = contextToSPJ(orni, currTupleSlice, ctx)
      def result: Relation = spj(problem.inputRelations)
      lazy val numBadTuples: Int = (result -- outputRelationSlice).numTuples
      lazy val score: Double = (numPossibleBadOutputTuples - numBadTuples).toDouble / size
    }
    implicit val pathOrdering: Ordering[QueueElement] = Ordering.by(elem => (elem.score, -elem.size))

    val queue = collection.mutable.PriorityQueue[QueueElement]()
    val peaks = collection.mutable.Set[EnumerationContext]()
    def recordQueueElement(ctx: EnumerationContext, parent: Option[QueueElement]): Option[QueueElement] = {
      if (peaks.forall(pk => !ctx.subsetOf(pk))) {
        val elem = QueueElement(ctx, parent)
        queue.enqueue(elem)
        peaks += ctx
        Some(elem)
      } else None
    }

    for ((relName, relation) <- problem.inputRelations if relation.schema.contains(targetConstant.domain);
         t <- relation.tuples if t.fields.contains(targetConstant)) {
      Logging.info(s"Recording seed context with tuple $relName($t)...")
      val st = SituatedTuple(relName, t)
      val result = recordQueueElement(prevCtx + st, None)
      result match {
        case Some(elem) => Logging.info(s"Success. numBadTuples: ${elem.numBadTuples}")
        case None => Logging.info("Skipping seed context.")
      }
    }
    var numPaths = 0L
    var longestPath = 0

    def ans: LazyList[QueueElement] = Timed {
      while (queue.nonEmpty) {
        val elem @ QueueElement(ctx, _) = queue.dequeue()

        Logging.info("---")
        Logging.info(s"queue.size: ${queue.size}")
        Logging.info(s"Path: ${elem.ctx.map(_.relName).toVector.sortBy(_.toString)}")
        Logging.info(s"Context:")
        for (SituatedTuple(relName, t) <- elem.ctx.toVector.sortBy(_.toString())) {
          Logging.info(s"  $relName($t)")
        }
        Logging.info(s"numBadTuples: ${elem.numBadTuples}")
        Logging.info(s"Size: ${elem.size}")
        Logging.info(s"Score: ${elem.score} (bad tuples eliminated / literal)")
        elem.parent match {
          case Some(parent) => Logging.info(s"Parent: ${parent.ctx.map(_.relName).toVector.sortBy(_.toString)}")
          case None =>
        }

        numPaths = numPaths + 1
        if ((numPaths & (numPaths - 1L)) == 0L) {
          longestPath = math.max(longestPath, elem.ctx.size - prevCtx.size)
          Logging.info(s"  Enumerated $numPaths paths. Longest path of length $longestPath.")
        }

        for (end <- elem.ends;
             edge <- constantGraph.edgesToVertex(end);
             t <- witnessTuples(edge)) {
          val st = SituatedTuple(edge.label.relName, t)
          recordQueueElement(ctx + st, Some(elem))
        }

        if (elem.numBadTuples == 0) {
          return elem #:: ans
        }
      }
      LazyList()
    }

    ans.map(_.ctx)
  }

}