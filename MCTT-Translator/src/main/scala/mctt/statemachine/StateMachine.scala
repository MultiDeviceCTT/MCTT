package mctt.statemachine

import mctt.{Task, AnnotatedTask}

trait SMConnectable{
  def ->(that: SMConnectable): Option[State]
  val correspondingTask: AnnotatedTask
}

abstract class SMElement(machineId: String) extends SMConnectable

class Transition(ev: String, currentTarget: String, machineId: String, notification: Boolean, var next: State = null, task: AnnotatedTask = null) extends SMElement(machineId){ 
  
  val event = ev
  val target = currentTarget
  val correspondingTask = task
  val isNotification = notification
  val machineID = machineId
  
  override def ->(that: SMConnectable) = {
    if(that.isInstanceOf[Transition]){
      var tmp_state = new SimpleState(this.event + "_finished", currentTarget, machineId, task = this.correspondingTask, isArtificial = true)
      this -> tmp_state
      tmp_state -> that.asInstanceOf[Transition]
      Some(tmp_state)
    }
    else if(that.isInstanceOf[State]){
      next = that.asInstanceOf[State]
      None
    }
    else{
      throw new Exception("Unknown SM type!")
    }
  }
  
  override def equals(that: Any) = {
    that.isInstanceOf[Transition] && that.asInstanceOf[Transition].event == this.event &&
    that.asInstanceOf[Transition].target == this.target &&
    that.asInstanceOf[Transition].machineID == this.machineID
  }
  
  def isCompletion = {
    event.trim() match {
      case "" => true
      case _  => false
    }
  }
  
  override def toString() = {
    event match {
      case "" => { "" }
      case _  => {
        target match {
          case "" => { event }
          case _  => { 
            isNotification match {
              case true => { "notify_" + event + "_finished_" + target}
              case _    => { event + "_" + target }
            }
          }
        }
      }
    } 
  }
  
  override def hashCode = toString().hashCode()
}

abstract class State(stateName: String, tar: String, machineId: String, isInitial: Boolean = false, isFinal: Boolean = false, isArtificial: Boolean = false, parentState: State = null) extends SMElement(machineId) {
  val name = stateName
  val target = tar
  val device = machineId
  val isartificial = isArtificial
  var parent = parentState
  var initial = isInitial
  var isfinal = isFinal
  var outgoingTransitions = Set.empty[Transition]
  var entryActions: Seq[String] = Seq.empty[String]
  var exitActions: Seq[String] = Seq.empty[String]
  
  override def ->(that: SMConnectable) = {
    if(that.isInstanceOf[State]){
      val transitionName = name + "_finished"
      val t = new Transition(transitionName, that.asInstanceOf[State].target, machineId, false, that.asInstanceOf[State])
      outgoingTransitions += t
      None
    }
    else if(that.isInstanceOf[Transition]){
      outgoingTransitions += that.asInstanceOf[Transition]
      None
    }
    else{
      throw new Exception("Unknown SM type!") 
    }
  }
  
  override def hashCode = toString().hashCode()
}

class SimpleState(override val name: String, override val target: String, machineId: String, isInitial: Boolean = false, isFinal: Boolean = false, task: AnnotatedTask = null, isArtificial: Boolean = false, parent: State = null) 
  extends State(name, target, machineId, isInitial, isFinal, isArtificial, parent) {
  val correspondingTask = task
  
  override def equals(that: Any) = {
    that.isInstanceOf[SimpleState] && that.asInstanceOf[SimpleState].toString() == this.toString()
  }
  
  override def toString() = {
    name + "_" + target + "_" + machineId
  }
}

class CompoundState(override val name: String, override val target: String, states: List[State],  machineId: String, isInitial: Boolean = false, isFinal: Boolean = false, isArtificial: Boolean = true, parent: State = null) 
  extends State(name, target, machineId, isInitial, isFinal, isArtificial, parent) {
  val substates = for (s <- states) yield { s.parent = this; s}
  val correspondingTask = states.filter { _.correspondingTask != null }.head.correspondingTask
  
  override def equals(that: Any) = {
    that.isInstanceOf[CompoundState] && that.asInstanceOf[CompoundState].toString() == this.toString()
  }
  
  override def toString() = machineId match { case "" => name + "_" + target case _  => name + "_" + target + "_" + machineId }
}

class ParallelState(override val name: String, states: List[State], machineId: String, isInitial: Boolean = false, isFinal: Boolean = false, isArtificial: Boolean = true, parent: State = null) 
  extends CompoundState(name, "", states, machineId, isInitial, isFinal, isArtificial, parent){
  override val correspondingTask = states.filter { _.correspondingTask != null }.head.correspondingTask
  override def toString() = machineId match { case "" => name case _ => name + "_" + machineId }
  
}
