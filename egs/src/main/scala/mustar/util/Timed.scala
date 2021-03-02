package mustar
package util

import scala.collection.mutable

object Timed {

  case class Timer(totalDuration: Long, invocations: Long, longestIndividualDuration: Long)
  private val timers: mutable.Map[String, Timer] = mutable.Map()

  def apply[T](thunk: => T)(implicit filename: sourcecode.FileName, lineNumber: sourcecode.Line): T = {
    Timed(s"${filename.value}:${lineNumber.value}")(thunk)
  }

  def apply[T](name: String)(thunk: => T): T = {
    val startTime = System.nanoTime()
    val ans: T = thunk
    val endTime = System.nanoTime()
    val thisDuration = endTime - startTime
    timers.synchronized {
      val timer = timers.getOrElseUpdate(name, Timer(0L, 0L, 0L))
      val newDuration = timer.totalDuration + thisDuration
      val newInvocations = timer.invocations + 1
      val newLongestIndividualDuration = Math.max(timer.longestIndividualDuration, thisDuration)
      timers += name -> Timer(newDuration, newInvocations, newLongestIndividualDuration)
    }
    ans
  }

  def getSnapshot: Map[String, Timer] = timers.toMap
  def reset(): Unit = timers.synchronized(timers.clear())

  Runtime.getRuntime.addShutdownHook(new Thread() {
    override def run(): Unit = {
      Logging.info("--- Timers ---")
      for ((name, timer) <- timers.toVector.sortBy(_._2.totalDuration)) {
        Logging.info(s"$name: ${timer.totalDuration / 1.0e9} seconds total, " +
                     s"${timer.invocations} invocations, " +
                     s"${timer.longestIndividualDuration / 1.0e9} seconds max")
      }
    }
  })

}
