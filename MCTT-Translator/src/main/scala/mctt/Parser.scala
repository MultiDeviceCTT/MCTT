package mctt

import scala.util.parsing.combinator.RegexParsers
import mctt.preprocessing.{LabelCollector, LabelAnnotator}

class Parser extends RegexParsers {
  def task: Parser[Task] = """[I|A]""".r ~ "_" ~ """[a-zA-Z0-9]+""".r ^^ { 
    case i ~ s ~ s2 => Task({if (i == "I") TaskType.Interaction else TaskType.Application}, s2) 
  }

  def all: Parser[All] = "all" ~> devlist ~ ("(" ~> expr <~ ")") ^^ {
    case dl ~ e1 => All(e1, dl)
  }

  def any: Parser[Any] = "any" ~> devlist ~ ("(" ~> expr <~ ")") ^^ {
    case dl ~ e1 => Any(e1, dl)
  }
  
  def devlist: Parser[List[String]] = dev*

  def dev: Parser[String] = "_"~"""[a-zA-Z0-9]+""".r  ^^ { case s1 ~ s2 => s2 }
  
  def choice: Parser[Choice] = "choice" ~ "(" ~> expr ~ ("," ~> expr <~ ")") ^^ {
    case e1 ~ e2 => Choice(e1, e2)
  }

  def disabling: Parser[Disabling] = "disabling" ~ "(" ~> expr ~ ("," ~> expr <~ ")") ^^ {
    case e1 ~ e2 => Disabling(e1, e2)
  }
  
  def reset: Parser[Reset] = "reset" ~ "(" ~> expr ~ ("," ~> expr <~ ")") ^^ {
    case e1 ~ e2 => Reset(e1, e2)
  }
  
  def repeat: Parser[Repeat] = "repeat" ~ "(" ~> expr <~ ")" ^^ {
    case e1 => Repeat(e1)
  } 
  
  def enabling: Parser[Enabling] = "enabling" ~ "(" ~> expr ~ ("," ~> expr <~ ")") ^^ {
    case e1 ~ e2 => Enabling(e1, e2)
  }

  def concurrent: Parser[Concurrent] = "concurrent" ~ "(" ~> expr ~ ("," ~> expr <~ ")") ^^ {
    case e1 ~ e2 => Concurrent(e1, e2)
  }
  
  def expr: Parser[Expr] = (all | any | choice | concurrent | disabling | reset | repeat | enabling | task)

  def eval(input: String) =
    parseAll(expr, input) match {
      case Success(result, _) => result
      case failure: NoSuccess => scala.sys.error(failure.msg)
    }
}