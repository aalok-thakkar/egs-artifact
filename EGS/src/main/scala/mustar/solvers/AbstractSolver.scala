package mustar
package solvers

import mustar.graphs.ConstantGraph.{ConstantGraph, EdgeLabel}
import mustar.automata.DFA
import mustar.graphs.CTBigraph.CTBigraph
import mustar.graphs.{CTBigraph, ConstantGraph, Edge}
import mustar.nonrecursiveQueries.{Rule, SPJ, UCQ}
import mustar.util.{Logging, Timed}

abstract class AbstractSolver(val problem: Problem) {

  val Problem(problemName, inputRelations, outputRelations) = problem

  lazy val constantGraph: ConstantGraph = ConstantGraph(problem)
  lazy val ctBigraph: CTBigraph = CTBigraph(problem)
  type EnumerationContext = Set[SituatedTuple]

  private val _witnessTuples = collection.mutable.Map[Edge[Constant, EdgeLabel], Set[DTuple]]()
  def witnessTuples(edge: Edge[Constant, EdgeLabel]): Set[DTuple] = {
    _witnessTuples.getOrElseUpdate(edge, ConstantGraph.allWitnessTuples(problem.inputRelations, edge))
  }

  def solveTuple(st: SituatedTuple): SPJ

  def solve(): Map[RelationName, UCQ] = Timed(s"Solve($problemName)") {
    problem.printHeader(println)

    if ((constantGraph.vertices.size < 500 && constantGraph.edges.size < 5000) || Options.LOG_LARGE_GRAPHS) {
      constantGraph.print(Logging.info)
    } else {
      Logging.info(s"Constant co-occurrence graph consists of ${constantGraph.vertices.size} vertices and " +
                   s"${constantGraph.edges.size} edges. Not logging graph!")
    }

    var soln = Map[RelationName, UCQ]()
    for (relName <- outputRelations.keys) {
      val ucq = solveRelationNonRec(relName)
      soln = soln + (relName -> ucq)
      // solveRelationRec(relName, ucq)
      println()
    }

    soln
  }

  def solveRelationRec(outputRelName: RelationName, ucq: UCQ): DFA[Int] = Timed(s"SolveRec($problemName)") {
    val outputRelation = outputRelations(outputRelName)
    assert(ucq(inputRelations) == outputRelation)
    RecursiveRollerV2.learnDFA(inputRelations, outputRelation, ucq)
  }

  def solveRelationNonRec(outputRelName: RelationName): UCQ = Timed(s"SolveNonRec($problemName)") {
    val outputRelation = outputRelations(outputRelName)

    Logging.info(s"Understanding $outputRelName")
    println(s"// $outputRelName:")
    var ucq = UCQ(outputRelName)
    var unexplainedTuples = outputRelation.tuples
    while (unexplainedTuples.nonEmpty) {
      Logging.info(s"  Yet to explain (${unexplainedTuples.size}):")
      for (t <- unexplainedTuples) {
        Logging.info(s"    ${outputRelName.name}($t)")
      }

      val currTuple = unexplainedTuples.head
      Logging.info(s"  Attempting to explain ${outputRelName.name}($currTuple)")
      val origSPJ = solveTuple(SituatedTuple(outputRelName, currTuple))
      val origRule = origSPJ.toRule
      val maxRule = Timed {
                      origRule.maximizeVars(inputRelations, outputRelation)
                              .minimizeLiterals(inputRelations, outputRelation)
                              .minimizeRegisters
                    }
      ucq = ucq + maxRule
      Logging.info(s"  origSPJ:  $origSPJ")
      Logging.info(s"  origRule: $origRule")
      Logging.info(s"  maxRule:  $maxRule")
      println(maxRule)

      val origSPJResult = origSPJ(inputRelations)
      val origRuleResult = origRule(inputRelations)
      val maxRuleResult = maxRule(inputRelations)
      assert(origSPJResult == origRuleResult)
      assert(origRuleResult.subsetOf(maxRuleResult))
      Logging.info(s"  Hypothesis explains:")
      for (t <- maxRuleResult.tuples) {
        if (origRuleResult.contains(t)) {
          Logging.info(s"    ${outputRelName.name}($t)")
        } else {
          Logging.info(s"    ${outputRelName.name}($t)*")
        }
        assert(outputRelation.contains(t), s"maxResultSPJ contains undesirable tuple $t")
      }
      unexplainedTuples = unexplainedTuples -- maxRuleResult.tuples
    }
    assert(ucq(inputRelations) == outputRelation)
    println()

    ucq = minimizeUCQ(ucq)
    assert(ucq(inputRelations) == outputRelation)
    println("// UCQ after minimization:")
    ucq.queries.foreach(rule => println(s"// $rule"))
    println()

    ucq
  }

  def minimizeUCQ(ucq: UCQ): UCQ = {
    val totalOutput = ucq(inputRelations)
    val ruleOutputs = ucq.queries.map(rule => rule -> rule(inputRelations)).toMap
    val emptyRelation = Relation(totalOutput.schema, Set())

    var necessaryRules = Set[Rule]()
    var unknownRules = ucq.queries

    while (unknownRules.nonEmpty) {
      val currRule = unknownRules.head
      unknownRules = unknownRules.tail
      val newOutput = (necessaryRules ++ unknownRules).map(ruleOutputs).foldLeft(emptyRelation)(_ ++ _)
      assert(newOutput.subsetOf(totalOutput))
      if (!totalOutput.subsetOf(newOutput)) {
        necessaryRules = necessaryRules + currRule
      }
    }

    UCQ(ucq.outputRelName, necessaryRules)
  }

}