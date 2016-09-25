package mctt.statemachine

/**
 * Singleton object to build a state machine from a MCTT
 * @author Andreas Wagner
 */
import mctt._
import mctt.statemachine._

object StateMachineBuilder {

  /**
   * Utility function: make a parallel machine from several distinct machines
   */
  def buildParallel(machines: List[Tuple3[Set[State], List[State], Set[State]]], labels: Set[String]) = {
    val compounds = for ((x, y) <- (labels, machines).zipped) yield new CompoundState(x, x, y._2, "")
    new ParallelState("system", compounds.toList, "", true)
  }
  
  /**
   * Utility function: create unique state names
   */
  import java.util.UUID
  def makeSaneStateName(strings: List[String]) = {
    if(strings.isEmpty){
      val shortUUID = UUID.randomUUID().toString().substring(15, 20)
      val regex = "-".r
      val shortUUIDpretty = regex.replaceAllIn(shortUUID, "_")
      shortUUIDpretty
    }
    else{
      strings.reduce((x,y) => s"${x}_${y}")
    }
  }

  /**
  * Utility function: make a state machine "well-formed"
  * e.g. introduce an initial state if none exists or make states final
  */
  def makeWellFormed(in: Set[_ <:SMConnectable], states: List[State], out: Set[_ <:SMConnectable], target: String, machineId: String): (Set[State], List[State], Set[State]) = {
    //assert(!states.isEmpty, "No states! No valid state machine!")
    
    var inSet = Set.empty[State]
    var allStates = states
    var outSet = Set.empty[State]
    
    //reform ingoing components
    var onlyInitialTransitions = in.map { x => x.isInstanceOf[Transition] }.reduce{(x,y) => x && y}
    var onlyInitialStates = in.map { x => x.isInstanceOf[State] }.reduce((x,y) => x && y)
    
    if(onlyInitialTransitions){
      val name = makeSaneStateName(List.empty[String])
      var newInitial = new SimpleState("init_" + name, target, machineId, true)
      in.foreach { x =>  
        newInitial -> x
      }
      allStates+:=newInitial
      inSet = Set(newInitial)
    }
    else if(onlyInitialStates){
      if( in.size > 1){
        throw new Exception("Unable to make StateMachine well-formed. More than one initial state exist!")
      }
      inSet = for(i <- in ) yield {i.asInstanceOf[State].initial = true; i.asInstanceOf[State]}
    }
    else{
      throw new Exception("Unable to make StateMachine well-formed due to issues in in-set!")
    }
    
    //reform outgoing components
    //new final state
    val name = "final_" + makeSaneStateName(List.empty[String])
    var finalState = new SimpleState( name, target, machineId, isFinal=true)
    outSet += finalState
    out.foreach{ x => 
      x match {
        case _ => { x -> finalState; allStates :+= finalState }
        //case x:State => { x.isfinal=true; outSet += x }
        //case _ => {}
      }  
    }
    
    (inSet, allStates, outSet)
  }
  
  /**
   * Utility function: make a state machine final
   */
  def makeFinal(in: Set[_ <:SMConnectable], states: List[State], out: Set[_ <:SMConnectable], target: String, machineId: String): (Set[SMConnectable], List[State], Set[State]) = {
    //assert(!states.isEmpty, "No states! No valid state machine!")
    
    var allStates = states
    var outSet = Set.empty[State]
    
    //reform outgoing components
    //new final state
    val name = "final_" + makeSaneStateName(List.empty[String])
    var finalState = new SimpleState( name, target, machineId, isFinal=true)
    outSet += finalState
    out.foreach{ x => 
      x match {
        case _ => { x -> finalState; allStates :+= finalState }
        //case x:State => { x.isfinal=true; outSet += x }
        //case _ => {}
      }  
    }
    
    (in.asInstanceOf[Set[SMConnectable]], allStates, outSet)
  }
  /**
   * Entry function for building state machines.
   * This function will call buildRec to build the SM recursively.
   */
  def build(target: String, allTargets: Set[String], tree: Expr, machineId: String) = {
    var (init, states, fin) = buildRec(target, allTargets, tree, false, machineId, false, target)
    
    makeWellFormed(init, states, fin, target, machineId)
  }

  /**
   * Function to build the state machines recursively.
   * This is where the "magic" happens.
   * Returns tuple representing a state machine, consisting of:
   *  - List of parts acting as "ingoing"
   *  - List of states
   *  - List of parts acting as "outgoing"
   */
  def buildRec(target: String, allTargets: Set[String], tree: Expr, forceTargetLabel: Boolean, machineId: String, isAllSubtree: Boolean, actualTarget: String): 
  (Set[SMConnectable], List[State], Set[SMConnectable]) = {
    tree match {
      //trivial case (tasks)
      
      //interaction task
      case AnnotatedTask(ttype: TaskType.Value, name: String, aLabels: Map[String, Set[String]], definedLabels: Set[String]) if ttype == TaskType.Interaction => {
        val t = new Transition(name, target, machineId, false, task = tree.asInstanceOf[AnnotatedTask])
        (Set(t).asInstanceOf[Set[SMConnectable]], List.empty[State], Set(t).asInstanceOf[Set[SMConnectable]])
      }

      //application task
      case AnnotatedTask(ttype: TaskType.Value, name: String, aLabels: Map[String, Set[String]], definedLabels: Set[String]) if ttype == TaskType.Application => {
        if(actualTarget == target){
          val s = new SimpleState(name, target, machineId, false, false, tree.asInstanceOf[AnnotatedTask])
          s.exitActions :+= name + "_finished" + "_" + s.target
          val transitionName = name + "_finished"
          val t = new Transition(transitionName, target, machineId, false)
          s -> t
          (Set(s).asInstanceOf[Set[SMConnectable]], List(s), Set(t).asInstanceOf[Set[SMConnectable]])
        }
        else{
          val s = new SimpleState("pending" + "_" + makeSaneStateName(List.empty[String]), target, machineId, false, false, tree.asInstanceOf[AnnotatedTask])
          val transitionName = name + "_finished"
          val t = new Transition(transitionName, target, machineId, false)
          s -> t
          (Set(s).asInstanceOf[Set[SMConnectable]], List(s), Set(t).asInstanceOf[Set[SMConnectable]])
        }
      }
      

      //ANY operator for general expression      
      case Any(expr: Expr, labels: List[String]) => {
        var begins = Set.empty[SMConnectable]
        var statess = List.empty[State]
        var ends = Set.empty[SMConnectable]
        labels.foreach{ label =>
          val mId = makeSaneStateName(List.empty[String])
          var (begin, states, end) = buildRec(label, allTargets, expr, true, s"${machineId}_${mId}", isAllSubtree, actualTarget)
          
          begins = begins union begin
          statess = statess ++ states
          ends = ends union end
        }
        (begins, statess, ends)
      }
      
      //ALL operator
      //The Subtrees for ALL must be generated in a way that tasks labeled with ANY are duplicated!
      case All(tree: Expr, labels: List[String]) => {
        // create parallels for each label
        // left
        val allpar = for(label <- labels) yield {
          // build for current label
          val mIdMain = s"${machineId}_${label}"
          val par = for(sublabel <- labels) yield {
            // build for current sublabel
            val mId = s"${mIdMain}_${sublabel}"
            var (in, states, out) = buildRec(sublabel, allTargets, tree, true, mId, true, actualTarget)
            // if the sublabel is equal to the label, we extract ingoing transitions
            if (sublabel == label){
              var (in_new, states_new, out_new) = makeFinal(in, states, out, target, mId)
              val ingoingTransitions = in_new.filter { _.isInstanceOf[Transition] }
              // pack in compound state
              val name = "comp_" + makeSaneStateName(List.empty[String])
              val compound = new CompoundState(name, target, states_new, mId)
              (ingoingTransitions, compound)
            }
            else{
              // pack in compound state
              // first make executable
              var (in_new, states_new, out_new) = makeWellFormed(in, states, out, target, mId)
              // build compound state
              val name = "comp_" + makeSaneStateName(List.empty[String])
              val compound = new CompoundState(name, target, states_new, mId)
              (Set.empty[Transition], compound)
            }
          }
          val inTransitions = par.map{ t => t._1.toSeq}.flatten.toSet
          val compounds = par.map{ c => c._2 }
          
          // build parallel state
          val parname = "par_" + makeSaneStateName(List.empty[String])
          var p = new ParallelState(parname, compounds, mIdMain)
          var t = new Transition(s"state.id.${parname}", target, mIdMain, false)
          p -> t
          (label, inTransitions, p, t)
        }
        
        val parlabels = allpar.map{ l => l._1 }
        val in = allpar.map       { t => t._2 }.flatten.toSet
        val parallels = allpar.map{ p => p._3 }
        val out = allpar.map      { o => o._4 }.toSet
        
        if(in.isEmpty){ // return the right parallel machine
          var parallelCandidates = allpar.filter{ p => p._1 == actualTarget}
          if (parallelCandidates.isEmpty){
            parallelCandidates = allpar.filter{ p => p._1 == target}
          }
          if (parallelCandidates.isEmpty){
            parallelCandidates = allpar
          }
          val par = parallelCandidates.head
          val parallel = par._3
          val out = par._4
          (Set(parallel), List(parallel), Set(out).asInstanceOf[Set[SMConnectable]])
        }
        else{
          (in.asInstanceOf[Set[SMConnectable]], parallels, out.asInstanceOf[Set[SMConnectable]])
        }
      }
      
      //ENABLING operator (sequence)
      case Enabling(e1: Expr, e2: Expr) => {
        var (input_l, states_l, output_l) = buildRec(target, allTargets, e1, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        var (input_r, states_r, output_r) = buildRec(target, allTargets, e2, forceTargetLabel, machineId, isAllSubtree, actualTarget)

        var newStates = List.empty[State]
        //connect end of left with start of right
        output_l.foreach { x =>
          input_r.foreach { y =>
            x -> y match {
              case Some(z) => {
                //a new state has been created
                if (newStates.contains(z)) {
                  //if state already existed, rearrange the connections so that 
                  //all participants point to the same state
                  var old_z_opt = newStates.find { s => s.toString() == z.toString() }
                  var old_z = old_z_opt.get
                  x -> old_z
                  old_z -> y
                }
                else {
                  newStates:+=z
                }
              }
              case _ => {}
            }
          }
        }
        
        (input_l, newStates ++ states_l ++ states_r, output_r)
      }

      //CHOICE operator
      case Choice(e1: Expr, e2: Expr) => {
        var (input_l, states_l, output_l) = buildRec(target, allTargets, e1, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        var (input_r, states_r, output_r) = buildRec(target, allTargets, e2, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        
        (input_l union input_r, states_l ++ states_r, output_l union output_r)
      }
      
      //DISABLING operator (global cancel)
      case Disabling(e1: Expr, e2: Expr) => {
        var (input_l, states_l, output_l) = buildRec(target, allTargets, e1, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        var (input_r, states_r, output_r) = buildRec(target, allTargets, e2, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        
        //compute a name
        val name = "comp_" + makeSaneStateName(List.empty[String])
        //create final states
        var (input_lf, states_lf, output_lf) = makeFinal(input_l, states_l, output_l, target, machineId) 
        //wrap up all states of e1 into a compound state
        var compound = new CompoundState(name, target, states_lf, machineId)
        
        //take all ingoing transitions of left
        var leftTransitions = input_lf.filter { _.isInstanceOf[Transition] }
        var rightTransitions = input_r.filter{ _.isInstanceOf[Transition] }
        
        //connect this hierarchical state with e2
        var newStates = Set.empty[State]
        input_r.foreach { x =>  
          compound -> x match {
            case Some(state) => {
              //a new state has been created
                if (newStates.contains(state)) {
                  //if state already existed, rearrange the connections so that 
                  //all participants point to the same state
                  var old_state = newStates.find { s => s.toString() == state.toString() }
                  x -> old_state
                }
            }
            case _ => {}
          }
        }
        //add outgoing finish transition
        var t = new Transition("state.id." + name, target, machineId, false)
        compound -> t
        
        //return only the state if transitions are empty (not quite correct, but feasible)
        if((leftTransitions).isEmpty){
          (Set(compound).asInstanceOf[Set[SMConnectable]], List(compound.asInstanceOf[State]) ++ newStates ++ states_r, output_r union Set(t))
        }
        else{
          (leftTransitions union rightTransitions, List(compound.asInstanceOf[State]) ++ newStates ++ states_r, output_r union Set(t))
        }
      }
      
      //CONCURRENT operator (independent execution)
      case Concurrent(e1: Expr, e2: Expr) => {
        // two parallels for left and right
        // left
        var (input_l1, states_l1, output_l1) = buildRec(target, allTargets, e1, forceTargetLabel, s"${machineId}_l", isAllSubtree, actualTarget)
        var (input_r1, states_r1, output_r1) = buildRec(target, allTargets, e2, forceTargetLabel, s"${machineId}_l", isAllSubtree, actualTarget)
        
        // make left final
        val (beginNew_ll, statesNew_ll, endNew_ll) = makeFinal(input_l1, states_l1, output_l1, target, s"${machineId}_l")
        // make right well-formed
        val (beginNew_rl, statesNew_rl, endNew_rl) = makeWellFormed(input_r1, states_r1, output_r1, target, s"${machineId}_l")
        // build compounds
        val name_ll = "comp_" + makeSaneStateName(List.empty[String])
        val name_rl = "comp_" + makeSaneStateName(List.empty[String])
        val compound_ll = new CompoundState(name_ll, target, statesNew_ll, machineId, true)
        val compound_rl = new CompoundState(name_rl, target, statesNew_rl, machineId, true)
        // parallel state
        val name_par_left = "par_" + makeSaneStateName(List.empty[String])
        var parallel_left = new ParallelState(name_par_left, List(compound_ll, compound_rl), machineId)
        //add an outgoing transition which indicates that the parallel state has finished
        var t_l = new Transition("state.id." + name_par_left, target, machineId, false)
        parallel_left -> t_l
        //extract input transitions
        val leftTransitions = beginNew_ll.filter { _.isInstanceOf[Transition] }
        
        // right
        var (input_l2, states_l2, output_l2) = buildRec(target, allTargets, e1, forceTargetLabel, s"${machineId}_r", isAllSubtree, actualTarget)
        var (input_r2, states_r2, output_r2) = buildRec(target, allTargets, e2, forceTargetLabel, s"${machineId}_r", isAllSubtree, actualTarget)
        
        // make right final
        val (beginNew_rr, statesNew_rr, endNew_rr) = makeFinal(input_r2, states_r2, output_r2, target, s"${machineId}_r")
        // make left well-formed
        val (beginNew_lr, statesNew_lr, endNew_lr) = makeWellFormed(input_l2, states_l2, output_l2, target, s"${machineId}_r")
        // build compounds
        val name_lr = "comp_" + makeSaneStateName(List.empty[String])
        val name_rr = "comp_" + makeSaneStateName(List.empty[String])
        val compound_lr = new CompoundState(name_lr, target, statesNew_lr, machineId, true)
        val compound_rr = new CompoundState(name_rr, target, statesNew_rr, machineId, true)
        // parallel state
        val name_par_right = "par_" + makeSaneStateName(List.empty[String])
        var parallel_right = new ParallelState(name_par_right, List(compound_lr, compound_rr), machineId)
        //add an outgoing transition which indicates that the parallel state has finished
        var t_r = new Transition("state.id." + name_par_right, target, machineId, false)
        parallel_right -> t_r
        //extract input transitions
        val rightTransitions = beginNew_rr.filter{ _.isInstanceOf[Transition] }
        
        //return
        (leftTransitions union rightTransitions, List(parallel_left, parallel_right), Set(t_l, t_r))
      }
      
      //RESET operator (resets a state machine) - quite similar to DISABLING, but sets e1 back to initial state
      case Reset(e1: Expr, e2: Expr) => {
        var (input_l, states_l, output_l) = buildRec(target, allTargets, e1, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        var (input_r, states_r, output_r) = buildRec(target, allTargets, e2, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        
        //make left part of reset well formed
        var (input_l2, states_l2, output_l2) = makeWellFormed(input_l, states_l, output_l, target, machineId)
        
        //compute a name
        val name = "comp_" + makeSaneStateName(List.empty[String])
        //wrap up all states of e1 into a compound state
        var compound = new CompoundState(name, target, states_l2, machineId)
        var t = new Transition("state.id." + name, target, machineId, false)
        compound -> t
        //connect this hierarchical state with e2
        var newStates = Set.empty[State]
        input_r.foreach { x =>  
          compound -> x match {
            case Some(state) => {
              //a new state has been created
                if (newStates.contains(state)) {
                  //if state already existed, rearrange the connections so that 
                  //all participants point to the same state
                  var old_state = newStates.find { s => s.toString() == state.toString() }
                  x -> old_state
                }
                else {
                  newStates += state
                }
            }
            case _ => {}
          }
        }
        //connect end of e2 with e1 -> create a loop to allow restart of e1
        output_r.foreach { x =>
            x -> compound match {
              case Some(state) => {
                if (newStates.contains(state)) {
                  var old_state = newStates.find { s => s.toString() == state.toString() }
                  old_state -> compound
                }
                else{
                  newStates += state
                }
              }
              case _ => {}
            }
        }
        (Set(compound.asInstanceOf[State]), List(compound.asInstanceOf[State]) ++ newStates ++ states_r, Set(t))
      }
      
      //REPEAT operator (iterates a task tree)
      case Repeat(e1: Expr) => {
        var (input, states, output) = buildRec(target, allTargets, e1, forceTargetLabel, machineId, isAllSubtree, actualTarget)
        
        //build a "loop" state
        val name = "loop_" + makeSaneStateName(List.empty[String])
        var loopState = new SimpleState(name, target, machineId)
        
        var newStates = Set.empty[State]
        
        //connect out-set with loopState
        output.foreach{ c =>
          c -> loopState match {
            case Some(s) => {
              newStates += s
            }
            case _       => {}
          }
        }
        
        //clone transitions of in-set
        var clonedIn = Set.empty[Transition]
        input.filter{ _.isInstanceOf[Transition] }.foreach { c =>
          val t = c.asInstanceOf[Transition]
          var clone = new Transition(t.event, t.target, machineId, t.isNotification, t.next, t.correspondingTask)
          clonedIn += clone
        }
        
        //connect loopState with cloned transitions
        clonedIn.foreach{ t =>
            loopState -> t
        }
        
        (input, states ++ newStates ++ List(loopState), Set(loopState))
      }
    }
  }
  
  
}