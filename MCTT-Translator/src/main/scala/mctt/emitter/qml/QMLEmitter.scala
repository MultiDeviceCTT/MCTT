package mctt.emitter.qml

import mctt.statemachine._
import mctt.emitter.qml._
import java.io.{File}

/**
 * This singleton prints a state machine to a QML state machine.
 * It uses the declarative QML state machine framework:
 * http://doc.qt.io/qt-5/qmlstatemachine.html
 * 
 * ProxyDumper supports the following features:
 *   - maps QML signals to SM signals
 *   - maps QML signals to UI elements
 *   - provides custom hooks to execute user-defined code
 * 
 * @author Andreas Wagner
 */

object ProxyDumper{
  
  def dump(path: File, fileToRead: File, debug: Boolean){
    val source = io.Source.fromFile(fileToRead)
    val content = source.getLines().mkString("\n")
    source.close()
    val signals = extractProxySignals(content)
    //group signals by proxy
    var proxyMap = scala.collection.mutable.Map.empty[String, Set[String]]
    signals.foreach{case (k,v) => 
      val keyparts = k.split("\\.")
      if(proxyMap.contains(keyparts(0).trim)){
        proxyMap(keyparts(0).trim) = proxyMap(keyparts(0).trim) union Set(keyparts(1).trim)
      }
      else{
        proxyMap(keyparts(0).trim) = Set(keyparts(1).trim)
      }
    }
    //dump a proxy file for each proxy
    proxyMap.keys.foreach{ proxy => 
      var pw = new PrettyPrinter(new File(path, s"${proxy.toUpperCase()}Proxy.qml"))
      pw.println("import QtQuick 2.0")
      pw.println("Item {")
      proxyMap(proxy).foreach { signal =>  
        pw.println(s"signal ${signal}(string data)")  
      }
      pw.println(s"signal genericSignal(string data)")
      pw.println("Connections {")
      pw.println(s"target: ${proxy}proxy")
      pw.println("onTransitionOccured: {")
      pw.println("switch(method){")
      proxyMap(proxy).foreach { signal =>
        val proxysignal = s"${proxy}.${signal}"
        val rawsignal = signals.getOrElse(proxysignal, "unknown")
        pw.println(raw"""case "$rawsignal": ${proxysignal}(data); break;""")  
      }
      pw.println(s"""default: console.log("method not known"); ${proxy}.genericSignal(data)""")
      pw.println("}")
      pw.println("}")
      pw.println("}")
      pw.println("}")
      pw.close()  
    }
    
    
  }
  
  def extractProxySignals(content: String): Map[String, String] = {
    val regex = "\\s*signal:(.*)/{2,}(.*)".r
    val matches = regex.findAllMatchIn(content)
    val signalTuples = for(m <- matches) yield {
      m.group(1).trim -> m.group(2).trim
    }
    Map(signalTuples.toSeq:_*)
  }
}

object SM2QML{
  
  var visited:Set[SMConnectable] = Set.empty[SMConnectable]
  
  def dump(part: SMConnectable, path: File, filename: String, settings: DeviceSettings, debug: Boolean) {
    //extract current device
    val device = settings.Name
    
    //organizational stuff for printing
    visited = Set.empty[SMConnectable]
    val outfile = new File(path, filename)
    val pw = new PrettyPrinter(outfile)
    
    //begin dump
    header(pw, device, settings, part.asInstanceOf[State].toString());
    val callbacks = dumpRec(part, pw, settings, Set.empty[Transition], debug)
    //print callback functions
    callbackFunctions(pw, callbacks)
    footer(pw);
    //close printer
    pw.close()
    
    //now create a proxy object for other devices
    //use previously dumped state machine for extracting the events
    ProxyDumper.dump(path, outfile, debug)
  }
  
  def dumpRec(part: SMConnectable, writer: PrettyPrinter, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean): Map[String, List[(String, Boolean)]] = {
    if(!visited.contains(part)){
      if (part.isInstanceOf[ParallelState]){
        val state = part.asInstanceOf[ParallelState]
        if( state.parent != null && !visited.contains(state.parent)){
          dumpRec(state.parent, writer, settings, parentTransitions, debug)
        }
        else{
          visited+=part
        
          val parentCallbacks = dumpParallelState(writer, state, settings, parentTransitions, debug)
          
          val childCallbacks = for(t <- state.outgoingTransitions) yield {
            dumpRec(t.next, writer, settings, parentTransitions, debug)
          }
          
          parentCallbacks ++ childCallbacks.flatten.map{ case (k,v) => k -> (v ++ parentCallbacks.getOrElse(k, List.empty[(String, Boolean)]))}
        }
      }
      else if (part.isInstanceOf[CompoundState]){
        //compound state
        val state = part.asInstanceOf[CompoundState]
        if( state.parent != null && !visited.contains(state.parent)){
          dumpRec(state.parent, writer, settings, parentTransitions, debug)
        }
        else{
          //prevent from being dumped several times
          visited+=part
          
          val parentCallbacks = dumpCompoundState(writer, state, settings, parentTransitions, debug)
          
          val childCallbacks = for(t <- state.outgoingTransitions) yield {
            dumpRec(t.next, writer, settings, parentTransitions, debug)
          }
          
          parentCallbacks ++ childCallbacks.flatten.map{ case (k,v) => k -> (v ++ parentCallbacks.getOrElse(k, List.empty[(String, Boolean)]))}
        }
      }
      else if(part.isInstanceOf[SimpleState]){
        //a simple state
        val state = part.asInstanceOf[SimpleState]
        if( state.parent != null && !visited.contains(state.parent)){
          dumpRec(state.parent, writer, settings, parentTransitions, debug)
        }
        else{
          //prevent from being dumped several times
          visited+=part
          //dump
          val callbacks = dumpSimpleState(writer, state, settings, parentTransitions, debug)
          //dump next state
          val nextCallbacks = for(t <- state.outgoingTransitions) yield {
            dumpRec(t.next, writer, settings, parentTransitions, debug)
          }
          
          callbacks ++ nextCallbacks.flatten.map{ case (k,v) => k -> (v ++ callbacks.getOrElse(k, List.empty[(String, Boolean)]))}
        }

      }
      else{
        Map.empty[String, List[(String, Boolean)]]
      }
    }
    else {
      Map.empty[String, List[(String, Boolean)]]
    }
  }
  
  /*
   * dump a parallel state
   */
  def dumpParallelState(pw: PrettyPrinter, s: ParallelState, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean): Map[String, List[(String, Boolean)]] = {
    //needed values
    val deviceName = s.device
    val initialState = s.substates.head
    //begin state
    pw.println("State {")
    //meta info
    pw.println(s"id: ${s.toString()}")
    pw.println("childMode: QState.ParallelStates")
    //transitions
    val transitionCallbacks = for(t <- s.outgoingTransitions) yield{ dumpTransition(pw, t, s, settings, debug) }
    //entry actions
    dumpEntryActions(pw, s, settings, parentTransitions, debug)
    //exit actions
    dumpExitActions(pw, s, settings, parentTransitions, debug)
    //substates
    //substate must be a compound state!
    val subCallbacks = for( sub <- s.substates ) yield { dumpRec(sub, pw, settings, s.outgoingTransitions union parentTransitions, debug) }
    //close state
    pw.println("}")
    //return
    val tmp =  transitionCallbacks.flatten.toMap
    tmp ++ subCallbacks.flatten.map{ case (k,v) => k -> (v ++ tmp.getOrElse(k, List.empty[(String, Boolean)])) }
  }
  
  /*
   * dump a compound state
   */
  def dumpCompoundState(pw: PrettyPrinter, s: CompoundState, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean): Map[String, List[(String, Boolean)]] = {
    //needed values
    val deviceName = s.device
    val initialState = s.substates.head
    //begin state
    pw.println("State {")
    //meta info
    pw.println(s"id: ${s.toString()}")
    pw.println(s"initialState: ${initialState.toString()}")
    //transitions
    val transitionCallbacks = for(t <- s.outgoingTransitions) yield { dumpTransition(pw, t, s, settings, debug) }
    //entry actions
    dumpEntryActions(pw, s, settings, parentTransitions, debug)
    //exit actions
    dumpExitActions(pw, s, settings, parentTransitions, debug)
    //substates
    val subCallbacks = dumpRec(s.substates.head, pw, settings, parentTransitions union s.outgoingTransitions, debug)
    //close state
    pw.println("}")
    //return
    val tmp =  transitionCallbacks.flatten.toMap
    tmp ++ subCallbacks.map{ case (k,v) => k -> (v ++ tmp.getOrElse(k, List.empty[(String, Boolean)])) }
  }
  
  /*
   * dump a simple state - return callbacks
   */
  def dumpSimpleState(pw: PrettyPrinter, s: SimpleState, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean): Map[String, List[(String, Boolean)]] = {
    //needed values
    val deviceName = s.device
    //determine state type
    val statetype = if(s.isfinal) "FinalState" else "State"
    //begin state
    pw.println(s"$statetype {")
    //print name
    pw.println(s"id: ${s.toString()}")
    //begin transitions
    val transitionCallbacks = for(t <- s.outgoingTransitions) yield { dumpTransition(pw, t, s, settings, debug) }
    //end transitions
    //entry actions
    dumpEntryActions(pw, s, settings, parentTransitions, debug)
    //exit actions
    dumpExitActions(pw, s, settings, parentTransitions, debug)
    //close state
    pw.println("}")
    //calculate callbacks
    if(s.correspondingTask != null){
        val cbSeq = for(a <- s.exitActions) yield {
        (s.correspondingTask.name -> List((raw"""local.broadcastTransition("${a}", "")""", false)))
      }
      val callbacks = Map(cbSeq:_*)
      //return
      callbacks ++ transitionCallbacks.flatten.map{ case (k,v) => k -> (v ++ callbacks.getOrElse(k, List.empty[(String, Boolean)]))}
    }
    else{
      transitionCallbacks.flatten.toMap
    }
  }
  
  /*
   * Dump a transition
   */
  def dumpTransition(pw: PrettyPrinter, t: Transition, s: State, settings: DeviceSettings, debug: Boolean): Map[String, List[(String, Boolean)]] = {
    val next = t.next.toString()
    val source = s.toString()
    val device = settings.Name
    val signals = settings.SignalMap
    val guards = settings.GuardMap
    val actions = settings.ActionMap

    pw.println("SignalTransition {")
    pw.println(s"targetState: $next")
    if(t.isCompletion) {
    	pw.println(s"id: ${source}2${next}")      
    }
    else{
      //check if transition is local
      val signal = if(t.target == device && t.correspondingTask != null){ //take signal from mapping or write note to user if no mapping exists
        signals.getOrElse(t.correspondingTask.name, "<missing signal>")
      }
      else if(t.target == device && t.correspondingTask == null && t.event.startsWith("state.id.")) { // outgoing transition of parallel state (finished)
         s"${s.toString()}.finished"
      }
      else if(t.target != device && t.correspondingTask == null && t.event.startsWith("state.id.")) { // outgoing transition of parallel state for remote
        s"${s.toString()}.finished"
      }
      else if(t.target == device && t.correspondingTask == null){ // self notification transition
        s"${notificationToSignal(t.event, true)}"
      }
      else{//write proxy notification
        s"${t.target}.${notificationToSignal(t.event, false)} // ${t.toString()}" 
      }
      pw.println(s"signal: ${signal}")
      //dump guards - default guards for locking, additional guards from GUI
      if(t.target == device){
        if(t.correspondingTask != null && guards.contains(t.correspondingTask.name)){//print guards if any have been defined
          pw.println(raw"""guard: local.hasLock() && ${guards(t.correspondingTask.name)}""")
        }
        else if(t.correspondingTask != null){
          pw.println(raw"""guard: local.hasLock()""")
        }
        else{}
      }
      if(t.target == device && !t.event.contains(".id.")){ //broadcast event to other devices if signal was triggered; avoid dummy transitions
        pw.println("onTriggered: {")
        if(t.correspondingTask != null && actions.contains(t.correspondingTask.name)){//if action is present, send data with broadcast
          pw.println(raw"""var data = ${actions(t.correspondingTask.name)}""")
          pw.println(raw"""local.broadcastTransition("${t.toString()}", data)""")
          pw.println(raw"""local.release()""") // release server lock
        }
        else if(t.correspondingTask != null){ //send raw broadcast
          pw.println(raw"""local.broadcastTransition("${t.toString()}", "")""")
          pw.println(raw"""local.release()""") // release server lock
        }
        else{
          //do nothing (for now)
        }
        pw.println("}")
      }
    }
    pw.println("}")
    if(!t.isCompletion && t.target == device && t.correspondingTask == null && s.correspondingTask != null && !t.event.startsWith("state.id.")){
      Map((s.correspondingTask.name, List((t.event, true))))
    }
    else if(!t.isCompletion && t.target == device && t.correspondingTask == null && s.correspondingTask == null && !t.event.startsWith("state.id.")){
      //write a default entry for artificial tasks
      Map(("dummy_" + t.event, List((t.event, true))))
    }
    else{
      Map.empty[String, List[(String, Boolean)]]
    }
  }
  
  /*
   * Dump exit actions of a state
   */
  def dumpExitActions(pw: PrettyPrinter, s: State, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean) = {
    val deviceName = s.device
    val stateName = s.toString()
    pw.println("onExited: {")
    if (debug) pw.println(raw"""console.log("$deviceName: $stateName exited")""")
    
    //disable controls which were valid for this state
    val inactiveCtrls = getControlsForDeactivation(s, parentTransitions, settings, false)
    inactiveCtrls.foreach { c => pw.println(s"${c}.${settings.DisablingPolicy.getOrElse(c, "enabled")} = false") }
    
    pw.println("}")
  }
  
  /*
   * Dump entry actions of a state
   */
  def dumpEntryActions(pw: PrettyPrinter, s: State, settings: DeviceSettings, parentTransitions: Set[Transition], debug: Boolean) = {
    val deviceName = s.device
    val stateName = s.toString()
    val device = settings.Name
    val actions = settings.ActionMap
    
    pw.println("onEntered: {")
    if (debug) pw.println(raw"""console.log("$deviceName: $stateName entered")""")
    //activate / deactivate UIControls
    pw.println("//update UI")
    val beforeActive = getControlsForActivation(s, parentTransitions, settings, true)
    beforeActive.foreach { c => pw.println(s"${c}.${settings.DisablingPolicy.getOrElse(c, "enabled")} = true") }
    
    //execute hooks
    if(s.target == device && s.correspondingTask != null && !s.isartificial){
      pw.println("//execute hooks, i.e. actual behavior code")
      val method = actions.getOrElse(s.correspondingTask.name, "//nothing to execute")
      //pass callback parameter
      //find where parameters start
      val paramsIdx = method.indexOf('(')
      if(paramsIdx > 0){
        val str = for (a <- s.exitActions) yield { s.correspondingTask.name + "_callback" }
        pw.println(method.substring(0, paramsIdx+1) + str.mkString + ")")
      }
    }
    
    val afterActive = getControlsForActivation(s, parentTransitions, settings, false)
    afterActive.foreach { c => pw.println(s"${c}.${settings.DisablingPolicy.getOrElse(c, "enabled")} = true") }
    
    //transition invocations for empty transitions
    s.outgoingTransitions.filter { _.isCompletion }.foreach { t => pw.println(s"${s.toString()}2${t.next.toString()}.invoke()") }
    pw.println("}")
  }
  
  /*
   * Write header needed for QML-files (imports, properties, etc.)
   */
  def header(pw: PrettyPrinter, device: String, settings: DeviceSettings, initialState: String) = {
    val controls = settings.UIControls
    pw.println("import QtQuick 2.0")
    pw.println("import QtQml.StateMachine 1.0")
    pw.println("StateMachine {")
    pw.println(s"id: stateMachine_$device")
    pw.println(s"initialState: $initialState")
    pw.println("//activate state machine")
    pw.println("running: true")
  }
  
  /*
   * print callback functions
   */
  def callbackFunctions(pw: PrettyPrinter, callbacks: Map[String, List[(String, Boolean)]]) = {
    callbacks.foreach{ case (k,v) => // print callback functions
      pw.println(s"function ${k}_callback(){")
      v.reverse.foreach { tuple =>
        if(tuple._2 == true){
          pw.println(notificationToSignal(tuple._1, true) + "()")
        }
        else{
          pw.println(tuple._1)
        }
      }
      pw.println("}")
    }
    callbacks.foreach{ case (k,v) => // print signal definitions
      v.foreach{ tuple =>
        if(tuple._2 == true){
          pw.println ( s"signal ${notificationToSignal(tuple._1, true)}" )
        }  
      }
    }
  }
  
  /*
   * end file properly
   */
  def footer(pw: PrettyPrinter) = 
    pw.println("}")
    
  /*
   * helper functions
   */
  def notificationToSignal(n: String, local: Boolean) : String = {
    val parts = n.split("_")
    val strings = for ((p,i) <- parts.filter{ _ != "notify"}.zipWithIndex) yield {
      if(i == 0) p.toLowerCase
      else p.capitalize
    }
    if(local){
      strings.mkString("")
    }
    else{
      strings.mkString("") + "Occured"
    }
  }
  
  def getControlsForActivation(s: State, parentTransitions: Set[Transition], settings: DeviceSettings, beforeExecution: Boolean): Set[String] = {
    val taskControls = settings.SignalMap.map{ case (k,v) => (k, v.split('.')(0)) }
    val additionalControls = settings.ControlsForTask
    val device = settings.Name
    
    if(beforeExecution){ // before execution, only parent transition controls may be active
      val activeControlsTransition = for(t <- parentTransitions.filter{ t => t.correspondingTask != null && t.target == device}) yield {
        val primaryControl = taskControls.getOrElse(t.correspondingTask.name, "//nocontrol")
        val secondaryControls = additionalControls.getOrElse(t.correspondingTask.name, Set.empty[String]).toSet
        secondaryControls union Set(primaryControl)
      }
      val activeControlsState = if(s.correspondingTask != null && !s.isartificial){
        additionalControls.getOrElse(s.correspondingTask.name, Set.empty[String]).toSet
      }
      else{
        Set.empty[String]
      }
      activeControlsTransition.flatten.asInstanceOf[Set[String]] union activeControlsState
    }
    else{ // after execution both parent and local controls may be active
      val activeControls = for(t <- s.outgoingTransitions.filter{ t => t.correspondingTask != null && t.target == device}) yield {
        val primaryControl = taskControls.getOrElse(t.correspondingTask.name, "//nocontrol")
        val secondaryControls = additionalControls.getOrElse(t.correspondingTask.name, Set.empty[String]).toSet
        secondaryControls union Set(primaryControl)
      }
      activeControls.flatten.asInstanceOf[Set[String]]
    }
  }
  
  def getControlsForDeactivation(s: State, parentTransitions: Set[Transition], settings: DeviceSettings, beforeExecution: Boolean): Set[String] = {
    val taskControls = settings.SignalMap.map{ case (k,v) => (k, v.split('.')(0)) }
    val additionalControls = settings.ControlsForTask
    val device = settings.Name
    
    val activeControlsState = if(s.correspondingTask != null && !s.isartificial){
        additionalControls.getOrElse(s.correspondingTask.name, Set.empty[String]).toSet
    }
    else{
      Set.empty[String]
    }
    
    val activeControlsTransition = for(t <- s.outgoingTransitions.filter{ t => t.correspondingTask != null && t.target == device}) yield {
        val primaryControl = taskControls.getOrElse(t.correspondingTask.name, "//nocontrol")
        val secondaryControls = additionalControls.getOrElse(t.correspondingTask.name, Set.empty[String]).toSet
        secondaryControls union Set(primaryControl)
      }
      activeControlsTransition.flatten.asInstanceOf[Set[String]] union activeControlsState
  }
}