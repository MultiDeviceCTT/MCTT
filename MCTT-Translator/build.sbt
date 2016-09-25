name			:=	"MCTT Parser"

version			:=	"0.1"

scalaVersion	:=	"2.11.5"

crossPaths := false

libraryDependencies += "org.scala-lang.modules" %% "scala-parser-combinators" % "1.0.3"
libraryDependencies += "junit" % "junit" % "4.8.1" % "test"
libraryDependencies += "org.scalafx" %% "scalafx" % "2.2.76-R11"

unmanagedJars in Compile += {
  val ps = new sys.SystemProperties
  val jh = ps("java.home")
  Attributed.blank(file(jh) / "lib/ext/jfxrt.jar")
}
