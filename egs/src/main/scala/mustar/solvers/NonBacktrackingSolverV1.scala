package mustar
package solvers

import mustar.graphs.ConstantGraph.{ConstantGraph, EdgeLabel}
import mustar.nonrecursiveQueries.SPJ
import mustar.util.{Logging, Timed}

class NonBacktrackingSolverV1(problem: Problem) extends AbstractSolver(problem) {

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
      ctx = solveField(problem, constantGraph, ctx, orni, outputRelationSlice, currTupleSlice, ci)
      Logging.info(s"  Explaining indices [0--$i] using $ctx")
    }

    val ans = contextToSPJOpt(outputRelName, currTuple, ctx)
    val ai = ans(problem.inputRelations)
    assert(ai.contains(currTuple))
    assert(ai.subsetOf(outputRelation))
    ans
  }

  def contextToSPJSimple(outputRelName: RelationName, currTuple: DTuple, ctx: EnumerationContext): SPJ = Timed {
    for (c <- currTuple.fields) {
      assert(ctx.exists(_.tuple.fields.contains(c)),
        s"Error while converting context to SPJ query. " +
        s"Target tuple: $currTuple. " +
        s"Unable to find constant $c in context $ctx")
    }

    val ctxVector = ctx.toVector.sortBy({ case SituatedTuple(relName, t) => s"$relName($t)" })
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
                  problem: Problem,
                  constantGraph: ConstantGraph,
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

        // TODO: The system is producing somewhat unexpected output. Check that the training data is clean and that the
        //   expected solution works.

        val opt1 = for (opt <- extend(n);
                        newCtx = currCtx ++ opt
                        if newCtx.exists(_.tuple.fields.contains(targetConstant)))
                   yield Timed("findNextLiteral:contextToSPJSimple") {
                     // 28 us, 15846 invocations, 447 ms total
                     val spj = contextToSPJSimple(orni, currTupleSlice, newCtx)
                     spj -> (opt, newCtx)
                   }
        Logging.info(s"opt1.size: ${opt1.size}")
        val opt2 = Timed("findNextLiteral:dedup-spj:simple") { opt1.toMap.values } // 28 ms total
        Logging.info(s"opt2.size: ${opt2.size}")
        val opt3 = for ((opt, newCtx) <- opt2)
                   yield Timed("findNextLiteral:contextToSPJOpt") {
                     // 22 ms, 483 invocations, 10731 ms total
                     val spj = contextToSPJOpt(orni, currTupleSlice, newCtx)
                     spj -> (opt, newCtx)
                   }
        Logging.info(s"opt3.size: ${opt3.size}")
        val opt4 = Timed("findNextLiteral:dedup-spj:opt") { opt3.toMap } // 1 ms total
        Logging.info(s"opt4.size: ${opt4.size}")
        val opt5 = for ((spj, (opt, newCtx)) <- opt4)
                   yield Timed("findNextLiteral:eval") {
                     // 14 ms, 413 invocations, 5721 ms total
                     val result = spj(problem.inputRelations)
                     val numGoodTuples = (result & outputRelationSlice).numTuples
                     val numBadTuples = (result -- outputRelationSlice).numTuples
                     (opt, newCtx, numGoodTuples, numBadTuples)
                   }
        Logging.info(s"opt5.size: ${opt5.size}")
        val options = opt5
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