package mustar
package nonrecursiveQueries

case class SPJSymbol(
                      precondition: IndexedSeq[Domain],
                      relationName: RelationName,
                      selections: Set[(Int, Int)],
                      projections: IndexedSeq[Int]
                    ) {

  val joinedSchema: IndexedSeq[Domain] = precondition ++ relationName.schema
  require(selections.forall({ case (i, j) => joinedSchema(i) == joinedSchema(j) }))
  val postcondition: Vector[Domain] = projections.map(precondition ++ relationName.schema).toVector

  def apply(t: DTuple)(thisRelation: Relation): Set[DTuple] = {
    require(t.schema == precondition)
    for (t2 <- thisRelation.tuples; jt = t ++ t2
         if selections.forall({ case (i, j) => jt(i) == jt(j) }))
      yield {
        val tAns = DTuple(projections.map(i => jt(i)))
        assert(tAns.schema == postcondition)
        tAns
      }
  }

  def apply(ts: Set[DTuple])(thisRelation: Relation): Set[DTuple] = ts.flatMap(t => this(t)(thisRelation))

  def normalizeFieldIndex(index: Int): Int = {
    val equalFields = collection.mutable.Set(index)
    var changed = true
    while (changed) {
      changed = false
      for ((i, j) <- selections if equalFields.contains(i) || equalFields.contains(j)) {
        changed = changed || !equalFields.contains(i) || !equalFields.contains(j)
        equalFields += i
        equalFields += j
      }
    }
    equalFields.min
  }

  override def toString: String = {
    val precondStr = precondition.mkString("(", ", ", ")")
    val joinStr = relationName.name
    val postSchema = precondition ++ relationName.schema
    val selectStr = postSchema.zipWithIndex
      .map({ case (domain, index) => (domain, normalizeFieldIndex(index)) })
      .map({ case (domain, index) => s"${domain.name(0).toLower}$index" })
      .mkString("(", ", ", ")")
    val projectStr = projections.map(index => {
      val domain = postSchema(index)
      s"${domain.name(0).toLower}${normalizeFieldIndex(index)}"
    }).mkString("(", ", ", ")")
    s"(Require $precondStr; _ * $joinStr; select $selectStr; project $projectStr)"
  }

}

object SPJSymbol {

  def apply(inputVariables: IndexedSeq[Variable], currLiteral: Literal, outputVars: IndexedSeq[Variable]): SPJSymbol = {
    val precondition = inputVariables.map(_.domain)
    val relName = currLiteral.relationName
    val joinedFields = inputVariables ++ currLiteral.fields
    val selections = for (i: Int <- joinedFields.indices.toSet;
                          j: Int <- joinedFields.indices.toSet
                          if joinedFields(i) == joinedFields(j))
                     yield (i, j)
    val projections = outputVars.map(v => joinedFields.indexOf(v))
    SPJSymbol(precondition, relName, selections, projections)
  }

}