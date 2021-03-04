package mustar
package solvers

import mustar.nonrecursiveQueries.SPJ
import mustar.util.{Logging, Timed}

class SolverV6(problem: Problem) extends AbstractSolver(problem) {

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
      val explanations = solveField(ctx, orni, outputRelationSlice, currTupleSlice, ci)
      if ( explanations.isEmpty) {
        System.out.println("Unrealizable.")
        System.exit(1)
      }
      ctx = explanations.head
      Logging.info(s"  Explaining indices [0--$i] using $ctx")
    }

    val ans = contextToSPJOpt(outputRelName, currTuple, ctx)
    val ai = ans(problem.inputRelations)
    assert(ai.contains(currTuple))
    assert(ai.subsetOf(outputRelation))
    ans
  }

  def contextToSPJFast(outputRelName: RelationName, currTuple: DTuple, ctx: EnumerationContext): SPJ = Timed {
    for (c <- currTuple.fields) {
      assert(ctx.exists(_.tuple.fields.contains(c)),
             s"Error while converting context to SPJ query. " +
             s"Target tuple: $currTuple. " +
             s"Unable to find constant $c in context $ctx")
    }

    val ctxVector = ctx.toVector.sortBy(_.toString)
    val joinExpr = ctxVector.map(_.relName)
    val sourceTuple = ctxVector.map(_.tuple).foldLeft(DTuple())(_ ++ _)
    SPJ(outputRelName, joinExpr, sourceTuple, currTuple)
  }

  def contextToSPJOpt(outputRelName: RelationName, currTuple: DTuple, ctx: EnumerationContext): SPJ = Timed {
    for (c <- currTuple.fields) {
      assert(ctx.exists(_.tuple.fields.contains(c)),
             s"Error while converting context to SPJ query. " +
             s"Target tuple: $currTuple. " +
             s"Unable to find constant $c in context $ctx")
    }

    val permutations = ctx.toVector.permutations
    val spjs = permutations.map(ctxVector => {
      val joinExpr = ctxVector.map(_.relName)
      val sourceTuple = ctxVector.map(_.tuple).foldLeft(DTuple())(_ ++ _)
      SPJ(outputRelName, joinExpr, sourceTuple, currTuple)
    })
    spjs.minBy(_.width)
  }

  def solveField(
                  prevCtx: EnumerationContext,
                  orni: RelationName,
                  outputRelationSlice: Relation,
                  currTupleSlice: DTuple,
                  targetConstant: Constant,
                ): LazyList[EnumerationContext] = Timed {
    Logging.info(s"Listing paths from $targetConstant")

    val vertices = constantGraph.vertices
    require(vertices.contains(targetConstant), s"Unrecognized constant $targetConstant. Vertices = $vertices.")

    val numPossibleOutputTuples = orni.schema.map(problem.domains).map(_.size).product
    val numPossibleBadOutputTuples = numPossibleOutputTuples - outputRelationSlice.numTuples
    Logging.info(s"numPossibleOutputTuples: $numPossibleOutputTuples")
    Logging.info(s"numPossibleGoodTuples: ${outputRelationSlice.numTuples}")
    Logging.info(s"numPossibleBadOutputTuples: $numPossibleBadOutputTuples")

    case class SPJResultStats(numTuples: Int, numGoodTuples: Int, numBadTuples: Int, numLiterals: Int) {
      val solved: Boolean = numBadTuples == 0
      def score: Double = (numPossibleBadOutputTuples - numBadTuples).toDouble / numLiterals
    }

    val spjFastSPJOptMap = collection.mutable.Map[SPJ, SPJ]()
    val spjOptScoreMap = collection.mutable.Map[SPJ, SPJResultStats]()

    case class QueueElement(ctx: EnumerationContext, parent: Option[QueueElement]) {
      def numLiterals: Int = ctx.size
      def ends: Set[Constant] = ctx.flatMap(_.tuple.fields)
      def spj: SPJ = {
        val spjFast = contextToSPJFast(orni, currTupleSlice, ctx)
        spjFastSPJOptMap.getOrElseUpdate(spjFast, contextToSPJOpt(orni, currTupleSlice, ctx))
      }
      lazy val stats: SPJResultStats = spjOptScoreMap.getOrElseUpdate(spj, {
        val result = spj(problem.inputRelations)
        val numTuples = result.numTuples
        val numGoodTuples = (result & outputRelationSlice).numTuples
        val numBadTuples: Int = (result -- outputRelationSlice).numTuples
        SPJResultStats(numTuples, numGoodTuples, numBadTuples, numLiterals)
      })
    }
    implicit val pathOrdering: Ordering[QueueElement] = Ordering.by(elem => (elem.stats.solved, elem.stats.score, -elem.numLiterals))

    val queue = collection.mutable.PriorityQueue[QueueElement]()
    val peaks = collection.mutable.Set[EnumerationContext]()
    def recordQueueElement(ctx: EnumerationContext, parent: Option[QueueElement]): Option[QueueElement] = Timed {
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
        case Some(elem) => Logging.info(s"Success. numTuples: ${elem.stats.numTuples}. " + s"numGoodTuples: ${elem.stats.numGoodTuples}. " +
                                        s"numBadTuples: ${elem.stats.numBadTuples}.")
        case None => Logging.info("Skipping seed context.")
      }
    }
    var numPaths = 0L
    var longestPath = 0

    def ans: LazyList[QueueElement] = {
      while (queue.nonEmpty) Timed {
        val elem @ QueueElement(ctx, _) = queue.dequeue()

        Logging.info("---")
        Logging.info(s"queue.size: ${queue.size}")
        Logging.info(s"Path: ${elem.ctx.toVector.map(_.relName).sortBy(_.toString)}")
        Logging.info(s"Context:")
        for (SituatedTuple(relName, t) <- elem.ctx.toVector.sortBy(_.toString())) {
          Logging.info(s"  $relName($t)")
        }
        Logging.info(s"numGoodTuples: ${elem.stats.numGoodTuples}")
        Logging.info(s"numBadTuples: ${elem.stats.numBadTuples}")
        Logging.info(s"Size: ${elem.numLiterals}")
        Logging.info(s"Score: ${elem.stats.score} (bad tuples eliminated / literal)")
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
          recordQueueElement(ctx + SituatedTuple(edge.label.relName, t), Some(elem))
        }

        if (elem.stats.numBadTuples == 0) {
          return elem #:: ans
        }
      }
      LazyList()
    }

    ans.map(_.ctx)
  }

}
