package mustar
package nonrecursiveQueries

import mustar.util.{Logging, Timed}

object SymbolExtractor {

  def apply(ucq: UCQ): Map[Rule, Disjunct] = Timed("SymbolExtractor") {
    Logging.info("Extracting SPJ symbols")
    var worklist = {
      val permutations = ucq.queries.map(rule => rule -> {
        val perms = rule.permutations
        val minRegisters = perms.map(_.numRegisters).min
        perms.filter(_.numRegisters == minRegisters)
      }).toMap

      for ((rule, perms) <- permutations)
      yield rule -> perms.map(rulePrime => Disjunct(rulePrime))
    }

    def pickWorklistElement(): Option[(Rule, Set[Disjunct])] = worklist.find(_._2.forall(_.remainingLiterals.nonEmpty))
    def worklistNonEmpty(): Boolean = pickWorklistElement().nonEmpty

    def worklistMeasure(wl: Map[Rule, Set[Disjunct]]): Int = wl.values.map(_.map(_.size).min).sum
    def transformWorklist(a: SPJSymbol): Map[Rule, Set[Disjunct]] = {
      for ((rule, ds) <- worklist)
      yield rule -> ds.map(d => d.applySymbol(a).map(_.shrink).getOrElse(d))
    }

    while (worklistNonEmpty()) {
      val (rule, disjuncts) = pickWorklistElement().get
      val potentialSymbols = for (d <- disjuncts; (a, _) <- d.nextSymbol)
                             yield {
                               val postWorklist = transformWorklist(a)
                               (a, d, postWorklist, worklistMeasure(postWorklist))
                             }

      val minResidualCost = potentialSymbols.map(_._4).min
      val (chosenSymbol, _, newWorklist, newWorklistMeasure) = potentialSymbols.filter(_._4 == minResidualCost)
                                                                               .minBy(_._1.toString)

      val initialWorklistMeasure = worklistMeasure(worklist)
      Logging.info(s"Initial worklist measure: $initialWorklistMeasure")
      Logging.info(s"Considering rule $rule")
      Logging.info(s"Picked symbol $chosenSymbol")
      Logging.info(s"New worklist measure: $newWorklistMeasure")
      assert(newWorklistMeasure < initialWorklistMeasure)

      worklist = newWorklist
    }

    for ((rule, disjuncts) <- worklist)
    yield rule -> {
      val solvedDisjunct = disjuncts.find(_.remainingLiterals.isEmpty).get
      assert(solvedDisjunct.projections.isEmpty)
      solvedDisjunct
    }
  }

  case class Disjunct(
                       remainingLiterals: IndexedSeq[Literal],
                       projections: IndexedSeq[Variable],
                       symbols: Vector[SPJSymbol],
                       permutedRule: Rule
                     ) {

    def size: Int = remainingLiterals.size

    def shrink: Disjunct = {
      for (a <- symbols) {
        applySymbol(a) match {
          case Some(d) => return d.shrink
          case None => ()
        }
      }
      this
    }

    def applySymbol(a: SPJSymbol): Option[Disjunct] = {
      if (remainingLiterals.nonEmpty) {
        this.nextSymbol.find(_._1 == a).map(_._2)
      } else None
    }

    def nextSymbol: Set[(SPJSymbol, Disjunct)] = {
      val leftLiterals = remainingLiterals.dropRight(1)
      val /* currLiteral @ */ Literal(currRelName, currFields) = remainingLiterals.last

      val leftVariables = leftLiterals.flatMap(_.fields).toSet
      val inputVariableSet = leftVariables & (currFields ++ projections).toSet

      def isSortedBy[T, B](vs: Seq[T])(f: T => B)(implicit ord: Ordering[B]): Boolean = vs == vs.sortBy(f)

      // We don't know in what order the input variables come in
      // An input order is a permutation of the variables in inputVariableSet
      // Given an input order, we know the selections that must hold
      // Given an input order, we know the projections which must happen
      // Therefore, given an input order, we can construct an SPJSymbol
      val ans = for (inputVariableSeq <- inputVariableSet.toVector.permutations
                     if isSortedBy(inputVariableSeq)(_.domain.name))
                yield {
                  val precondition = inputVariableSeq.map(_.domain)
                  val joinedFields = inputVariableSeq ++ currFields
                  val selections = for (i: Int <- joinedFields.indices.toSet;
                                        j: Int <- joinedFields.indices.toSet
                                        if joinedFields(i) == joinedFields(j))
                                   yield (i, j)
                  val symbolProjections = projections.map(v => joinedFields.indexOf(v))
                  assert(symbolProjections.forall(_ >= 0))
                  val symbol = SPJSymbol(precondition, currRelName, selections, symbolProjections)

                  val newDisjunct = Disjunct(leftLiterals, inputVariableSeq, symbol +: symbols, permutedRule)
                  (symbol, newDisjunct)
                }

      ans.toSet
    }

  }

  object Disjunct {
    def apply(rule: Rule): Disjunct = Disjunct(rule.body, rule.head.fields, Vector(), rule)
  }

  def preimage(
                literal: Literal,
                symbol: SPJSymbol,
                outputVars: IndexedSeq[Variable]
              ): Option[IndexedSeq[Variable]] = {
    if (symbol.relationName != literal.relationName || symbol.postcondition != outputVars.map(_.domain)) {
      return None
    }

    var joinedFields = symbol.precondition.map(_ => None) ++ literal.fields.map(v => Some(v))

    for ((i, vOut) <- symbol.projections.zip(outputVars)) {
      joinedFields(i) match {
        case Some(v) if v != vOut => return None
        case None => joinedFields = joinedFields.updated(i, Some(vOut))
        case Some(v) => assert(v == vOut)
      }
    }

    var changed = true
    while (changed) {
      changed = false
      for ((i, j) <- symbol.selections) {
        (joinedFields(i), joinedFields(j)) match {
          case (sv @ Some(_), None) =>
            joinedFields = joinedFields.updated(j, sv)
            changed = true
          case (None, sv @ Some(_)) =>
            joinedFields = joinedFields.updated(i, sv)
            changed = true
          case (Some(vi), Some(vj)) if vi != vj =>
            return None
          case (Some(vi), Some(vj)) => assert(vi == vj)
          case (None, None) => ()
        }
      }
    }

    Some(joinedFields.take(symbol.precondition.length).map(_.get))
  }

}
