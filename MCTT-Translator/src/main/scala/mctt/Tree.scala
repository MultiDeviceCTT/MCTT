package mctt

object TaskType extends Enumeration {
  var TaskType = Value
  val Interaction, Application = Value
}

//Syntax tree
abstract class Expr { var activatedBy: Seq[Task] = Seq.empty[Task]; var containsLabel = Set.empty[String]}
case class Enabling(e1: Expr, e2: Expr) extends Expr
case class Disabling(e1: Expr, e2: Expr) extends Expr
case class Reset(e1: Expr, e2: Expr) extends Expr
case class Repeat(e1: Expr) extends Expr
case class Choice(e1: Expr, e2: Expr) extends Expr
case class Concurrent(e1: Expr, e2: Expr) extends Expr
case class Any(e1: Expr, devices: List[String]) extends Expr 
case class All(e1: Expr, devices: List[String]) extends Expr
case class Task(ttype: TaskType.Value, name: String) extends Expr { override def hashCode = name.hashCode() }
case class AnnotatedTask(ttype: TaskType.Value, name: String, activeLabels: Map[String, Set[String]], definedLabels: Set[String]) extends Expr