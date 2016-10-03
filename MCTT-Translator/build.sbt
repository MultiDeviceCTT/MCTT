import de.heikoseeberger.sbtheader.HeaderPattern

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

headers := headers.value ++ Map(
  "scala" -> (
    HeaderPattern.cStyleBlockComment,
    """|/*******************************************************************************
       |* Copyright (c) 2016 Andreas Wagner.
       |* All rights reserved. This program and the accompanying materials
       |* are made available under the terms of the Eclipse Public License v1.0
       |* which accompanies this distribution, and is available at
       |* http://www.eclipse.org/legal/epl-v10.html
       |* 
       |* Contributors:
       |*     Andreas Wagner - Concept and implementation
       |*     Christian Prehofer - Concept
       |*******************************************************************************/
       |""".stripMargin
  )
)