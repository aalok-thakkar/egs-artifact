package mustar

import mustar.solvers._
import mustar.util.{Logging, Timed}

object Main extends App {

  Timed("Main") {
    Logging.info("Hello!")
    Logging.info {
      val nl = System.lineSeparator()
      val argsStr = this.args.map(arg => s"  $arg").mkString(nl)
      s"Mustar invoked with options:" + nl + argsStr
    }

    this.args.foreach(problemDirectory => {
      Logging.info("################################################################################")
      Logging.info(s"Solving problem instance in directory $problemDirectory")
      println("////////////////////////////////////////////////////////////////////////////////")
      println(s"// Solving problem instance in directory $problemDirectory")

      val problem = Problem(problemDirectory)
      val problemSize = (problem.inputRelations ++ problem.outputRelations).values.map(_.numTuples).sum
      if (problemSize <= 1000 || Options.LOG_LARGE_PROBLEMS) {
        Logging.info(problem.toString)
      } else {
        Logging.info(s"Problem consists of $problemSize tuples. Not logging training data!")
      }

      val solver = new SolverV6(problem)
      solver.solve()
    })

    Logging.info("################################################################################")
    Logging.info("Bye!")
  }

}
