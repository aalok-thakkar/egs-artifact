package mustar
package nonrecursiveQueries

import mustar.util.Timed

case class Rule(head: Literal, body: IndexedSeq[Literal]) {

  val headVars: Set[Variable] = head.fields.toSet
  val bodyVars: Set[Variable] = body.flatMap(_.fields).toSet
  require(headVars.subsetOf(bodyVars))

  def outputRelName: RelationName = head.relationName
  override def toString: String = s"$head :- ${body.mkString(", ")}."

  def apply(inputRelations: Map[RelationName, Relation]): Relation = Timed {
    // 30 ms, 11% of running time, 2487 ms total
    var currAsgns = Set(Map[Variable, Constant]())

    for ((Literal(relName, fields), index) <- body.zipWithIndex) {
      def unify(asgn: Map[Variable, Constant], t: DTuple): Option[Map[Variable, Constant]] = {
        var ans = asgn
        for ((v, c) <- fields.zip(t.fields)) {
          if (ans.contains(v) && ans(v) != c) {
            return None
          }
          ans = ans + (v -> c)
        }
        Some(ans)
      }

      val necessaryVars = (body.drop(index + 1).flatMap(_.fields) ++ head.fields).toSet

      // By definition, unify involves selection pushdowns
      currAsgns = for (asgn <- currAsgns; t <- inputRelations(relName).tuples; newAsgn <- unify(asgn, t))
                  yield newAsgn.view.filterKeys(necessaryVars).toMap // Projection pushdown
    }

    val ans = currAsgns.map(asgn => DTuple(head.fields.map(asgn)))
    Relation(head.schema, ans)
  }

  lazy val usefulVariables: Set[Variable] = {
    val ans = collection.mutable.Set[Variable]()
    ans ++= this.head.fields
    var changed = true
    while (changed) {
      changed = false
      for (literal <- body; v1 <- literal.fields if ans.contains(v1); v2 <- literal.fields) {
        if (!ans.contains(v2)) {
          ans += v2
          changed = true
        }
      }
    }
    ans.toSet
  }

  def keepUsefulLiterals: Rule = {
    val usefulLiterals = body.filter(_.fields.exists(usefulVariables.contains))
    Rule(head, usefulLiterals)
  }

  def maximizeVars(inputRelations: Map[RelationName, Relation], referenceOutput: Relation): Rule = {
    var numOccurrences = this.body.flatMap(_.fields).groupBy(v => v).map({ case (v, vs) => v -> vs.length })
    def newVar(domain: Domain): Variable = {
      val pre = domain.name(0).toLower.toString
      var counter = 1
      var ans = Variable(s"$pre$counter", domain)
      while (numOccurrences.contains(ans)) {
        counter = counter + 1
        ans = Variable(s"$pre$counter", domain)
      }
      ans
    }

    var (currLeft, currRight) = (Vector[Literal](), this.body)
    while (currRight.nonEmpty) {
      val Literal(relName, fields) = currRight.head
      currRight = currRight.tail

      var newFields = fields
      for (i <- newFields.indices) {
        val v = newFields(i)
        if (numOccurrences(v) > 1) {
          val nv = newVar(v.domain)
          val nf2 = newFields.updated(i, nv)
          val newLit = Literal(relName, nf2)
          val newRule = Rule(head, (currLeft :+ newLit) ++ currRight).keepUsefulLiterals
          if (newRule(inputRelations).subsetOf(referenceOutput)) {
            newFields = nf2
            numOccurrences = numOccurrences + (v -> (numOccurrences(v) - 1)) + (nv -> 1)
          }
        }
      }

      currLeft = currLeft :+ Literal(relName, newFields)
    }
    Rule(head, currLeft).keepUsefulLiterals
  }

  def minimizeLiterals(inputRelations: Map[RelationName, Relation], referenceOutput: Relation): Rule = {
    val originalOutput = this(inputRelations)
    require(originalOutput.subsetOf(referenceOutput))

    var necessaryLiterals = Vector[Literal]()
    var unknownLiterals = this.body
    while (unknownLiterals.nonEmpty) {
      val currLiteral = unknownLiterals.head
      unknownLiterals = unknownLiterals.tail
      val newBodyVars = (necessaryLiterals ++ unknownLiterals).flatMap(_.fields).toSet
      lazy val newRule = Rule(head, necessaryLiterals ++ unknownLiterals)
      lazy val newOutput = newRule(inputRelations)
      if (!headVars.subsetOf(newBodyVars) || !newOutput.subsetOf(referenceOutput)) {
        necessaryLiterals = necessaryLiterals :+ currLiteral
      }
    }
    Rule(head, necessaryLiterals)
  }

  def crossingFields(numLeftFields: Int): Set[Variable] = {
    val variablesDefinedBefore = body.take(numLeftFields).flatMap(_.fields).toSet
    val variablesUsedAfter = body.drop(numLeftFields).flatMap(_.fields).toSet ++ head.fields
    variablesDefinedBefore & variablesUsedAfter
  }

  lazy val numRegisters: Int = (0 to body.size + 1).map(numLeftFields => crossingFields(numLeftFields).size).max
  def permutations: Set[Rule] = body.permutations.map(bodyPrime => Rule(head, bodyPrime)).toSet
  def minimizeRegisters: Rule = permutations.minBy(_.numRegisters)

}