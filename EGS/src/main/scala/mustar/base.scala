package mustar

case class Domain(name: String) {
  override def toString: String = name
}

sealed abstract class Parameter {
  def name: String
  def domain: Domain
  override def toString: String = name
}

case class Constant(name: String, domain: Domain) extends Parameter
case class Variable(name: String, domain: Domain) extends Parameter

case class DTuple(fields: IndexedSeq[Constant]) extends (Int => Constant) {
  def schema: IndexedSeq[Domain] = fields.map(_.domain)
  def apply(i: Int): Constant = fields(i)
  override def toString: String = fields.mkString("(", ", ", ")")
  def ++(that: DTuple): DTuple = DTuple(this.fields ++ that.fields)
  def slice(from: Int, until: Int): DTuple = DTuple(fields.slice(from, until))
}

object DTuple {
  private val unitTuple: DTuple = DTuple(Vector())
  def apply(): DTuple = unitTuple
}

case class Relation(schema: IndexedSeq[Domain], tuples: Set[DTuple]) {
  require(tuples.forall(_.schema == schema))
  // TODO: Logging.reportSize("schema, tuples.size")

  def numTuples: Int = tuples.size

  def ++(that: Relation): Relation = {
    require(this.schema == that.schema)
    Relation(schema, tuples ++ that.tuples)
  }

  def --(that: Relation): Relation = {
    require(this.schema == that.schema)
    Relation(schema, tuples -- that.tuples)
  }

  def &(that: Relation): Relation = {
    require(this.schema == that.schema)
    Relation(schema, tuples & that.tuples)
  }

  def slice(from: Int, until: Int): Relation = {
    val slicedSchema = schema.slice(from, until)
    val slicedTuples = tuples.map(_.slice(from, until))
    Relation(slicedSchema, slicedTuples)
  }

  def contains(t: DTuple): Boolean = {
    require(this.schema == t.schema)
    this.tuples.contains(t)
  }

  def subsetOf(that: Relation): Boolean = {
    require(this.schema == that.schema)
    this.tuples.subsetOf(that.tuples)
  }
}

case class RelationName(name: String, schema: IndexedSeq[Domain]) {
  override def toString: String = s"$name(${schema.mkString(", ")})"
}

case class SituatedTuple(relName: RelationName, tuple: DTuple)