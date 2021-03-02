scalaVersion := "2.13.2"

lazy val egs = (project in file("."))
  .settings(
    name := "egs",
    // System.err.println is better!
    // libraryDependencies += "ch.qos.logback" % "logback-classic" % "1.2.3",
    // libraryDependencies += "com.typesafe.scala-logging" %% "scala-logging" % "3.9.2",
    libraryDependencies += "com.lihaoyi" %% "sourcecode" % "0.1.9",
    libraryDependencies += "org.scalatest" %% "scalatest" % "3.1.1" % Test
  )

// scalac -help; scalac -X; scalac -Xlint:help; scalac -Y
scalacOptions ++= Seq(
  "-Werror",
  "-deprecation",
  "-feature",
  "-unchecked",
  "-Xfatal-warnings"
)
