package mustar
package util

import java.text.DateFormat

object Logging {

  val timestampFormatter: DateFormat = java.text.DateFormat.getDateTimeInstance

  def printMsg(msgType: String, file: sourcecode.FileName, line: sourcecode.Line, msg: Any): Unit = {
    val date = new java.util.Date()
    val dateStr = timestampFormatter.format(date)
    System.err.println(s"$dateStr $msgType ${file.value}:${line.value} $msg")
  }

  def infoOut(msg: => Any)(implicit file: sourcecode.FileName, line: sourcecode.Line): Unit = {
    info(msg)(file, line)
    println(msg)
  }

  def info(msg: => Any)(implicit file: sourcecode.FileName, line: sourcecode.Line): Unit = {
    printMsg("INFO", file, line, msg)
  }

  def warn(msg: => Any)(implicit line: sourcecode.Line, file: sourcecode.FileName): Unit = {
    printMsg("WARN", file, line, msg)
  }

  def error(msg: => Any)(implicit line: sourcecode.Line, file: sourcecode.FileName): Unit = {
    printMsg("ERROR", file, line, msg)
  }

}
