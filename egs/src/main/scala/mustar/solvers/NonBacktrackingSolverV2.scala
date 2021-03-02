package mustar
package solvers

import mustar.graphs.ConstantGraph.EdgeLabel
import mustar.nonrecursiveQueries.SPJ
import mustar.util.{Logging, Timed}

class NonBacktrackingSolverV2(problem: Problem) extends AbstractSolver(problem) {

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
      ctx = solveField(ctx, orni, outputRelationSlice, currTupleSlice, ci)
      Logging.info(s"  Explaining indices [0--$i] using $ctx")
    }

    val ans = contextToSPJOpt(outputRelName, currTuple, ctx)
    val ai = ans(problem.inputRelations)
    assert(ai.contains(currTuple))
    assert(ai.subsetOf(outputRelation))
    ans
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
                  targetConstant: Constant
                ): EnumerationContext = {
    val vertices = constantGraph.vertices
    require(vertices.contains(targetConstant), s"Unrecognized constant $targetConstant. Vertices = $vertices.")

    Logging.info(s"Listing paths from $targetConstant")

    val numPossibleOutputTuples = orni.schema.map(problem.domains).map(_.size).product
    val numPossibleBadOutputTuples = numPossibleOutputTuples - outputRelationSlice.numTuples
    Logging.info(s"numPossibleOutputTuples: $numPossibleOutputTuples")
    Logging.info(s"numPossibleGoodTuples: ${outputRelationSlice.numTuples}")
    Logging.info(s"numPossibleBadOutputTuples: $numPossibleBadOutputTuples")

    var currCtx = prevCtx
    var ends = currCtx.flatMap(_.tuple.fields) + targetConstant
    var currNumBadTuples = Integer.MAX_VALUE

    // TODO: Can we make this produce its outputs lazily?
    def extend(n: Int): Set[Set[SituatedTuple]] = {
      require(n >= 0)
      if (n == 0) {
        Set(Set())
      } else {
        for (exnInd <- extend(n - 1);
             newEnds = ends ++ exnInd.flatMap(_.tuple.fields);
             c <- newEnds;
             edge <- constantGraph.edgesFromVertex(c);
             relName = edge.label.relName;
             t <- witnessTuples(edge);
             st = SituatedTuple(relName, t)
             if !currCtx.contains(st) && !exnInd.contains(st))
        yield exnInd + st
      }
    }

    while (currNumBadTuples > 0) Timed("findNextLiteral") { // 963 ms, 80% of running time, 17329 ms total
      LazyList.from(1).find(n => {
        Logging.info(s"Considering extensions of length $n")

        // TODO:
        //   1. Build new BFS solver which maintains a queue of points on the precision-recall Pareto curve
        //      - Consider two options which are incomparable wrt. (numGoodTuples, numBadTuples)
        //      - How do you compare Option 1 with (numGoodTuples=10, numBadTuples=10), with
        //                           Option 2 with (numGoodTuples=5, numBadTuples=5)?
        //   2. Speed up contextToSPJOpt by building on previous optimal result, and only considering places to add the
        //      new extending tuples in opt
        //   3. Can we reintroduce some kind of prioritization based on graph theoretic / topological arguments?
        //      For example, distance from targetConstant?
        //   4. Instead of a BFS, what about a DFS, within limits?
        //      "This is the classic overfitting problem. One solution to this problem, in other fields, has been to
        //      limit the depth of the decision tree, and backtrack when we hit the limit."

        val currCtxVector = currCtx.toVector
        val currCtxVectorConstantIndexMap = currCtxVector.map(_.tuple).flatMap(_.fields)
                                                         .zipWithIndex.toMap
        def newSPsSimple(opt: Set[SituatedTuple]): (Vector[RelationName], Set[(Int, Int)], Int) = {
          val optVector = opt.toVector.sortBy(_.toString)

          val joinRels = optVector.map(_.relName)

          val optVectorFlattened = optVector.flatMap(_.tuple.fields)
          val newSelections = for ((c, i) <- optVectorFlattened.zipWithIndex
                                   if currCtxVectorConstantIndexMap.contains(c))
                              yield (currCtxVectorConstantIndexMap(c), i + currCtxVector.size)

          val newProjection = currCtxVectorConstantIndexMap.getOrElse(targetConstant,
                                                                      optVectorFlattened.indexOf(targetConstant) +
                                                                      currCtxVector.size)
          (joinRels, newSelections.toSet, newProjection)
        }

        val opts1 = for (opt <- extend(n)
                         if currCtxVectorConstantIndexMap.contains(targetConstant) ||
                            opt.exists(_.tuple.fields.contains(targetConstant)))
                    yield Timed("findNextLiteral:SP") {
                      newSPsSimple(opt) -> opt
                    }
        Logging.info(s"opts1.size: ${opts1.size}")
        val opts2 = Timed("findNextLiteral:dedup-sp") { opts1.toMap.values }
        Logging.info(s"opts2.size: ${opts2.size}")
        val opts3 = for (opt <- opts2)
                    yield Timed("findNextLiteral:contextToSPJOpt") {
                      val newCtx = currCtx ++ opt
                      val spj = contextToSPJOpt(orni, currTupleSlice, newCtx)
                      spj -> (opt, newCtx)
                    }
        Logging.info(s"opts3.size: ${opts3.size}")
        val opts4 = Timed("findNextLiteral:dedup-spjopt") { opts3.toMap }
        Logging.info(s"opts4.size: ${opts4.size}")
        val opts5 = for ((spj, (opt, newCtx)) <- opts4)
                    yield Timed("findNextLiteral:eval") {
                      val result = spj(problem.inputRelations)
                      val numGoodTuples = (result & outputRelationSlice).numTuples
                      val numBadTuples = (result -- outputRelationSlice).numTuples
                      (opt, newCtx, numGoodTuples, numBadTuples)
                    }
        Logging.info(s"opts5.size: ${opts5.size}")
        val options = opts5
        assert(options.nonEmpty)

        // TODO: It is not just the number of good tuples, but also the number of unexplained tuples which matters
        val (sts, newCtx, numGoodTuples, numBadTuples) = options.minBy(opt => (opt._4, -opt._3))

        if (currNumBadTuples == numBadTuples) {
          false
        } else {
          Logging.info({
            val optStr = sts.map({ case SituatedTuple(relName, t) => s"$relName($t)"}).mkString("{", ", ", "}")
            s"Extending context with $optStr. numGoodTuples = $numGoodTuples. numBadTuples = $numBadTuples."
          })
          currCtx = newCtx
          ends = ends ++ sts.flatMap(_.tuple.fields)
          currNumBadTuples = numBadTuples
          true
        }
      })
    }

    currCtx
  }

}
