/*******************************************************************************
* Copyright (c) 2016 Andreas Wagner.
* All rights reserved. This program and the accompanying materials
* are made available under the terms of the Eclipse Public License v1.0
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v10.html
* 
* Contributors:
*     Andreas Wagner - Concept and implementation
*     Christian Prehofer - Concept
*******************************************************************************/
package mctt.emitter.qml

import java.io.{File, BufferedReader, FileReader}

/**
 * Loads a file which contains mappings between tasks and QML GUI.
 * Exploits regular expressions.
 * 
 * @author Andreas Wagner
 */
object MappingParser{
  
  def load(f: File): Map[String, DeviceSettings] = {
    val sec = "\\s*\\[([^]]*)\\]\\s*".r
    val kv  = "\\s*([^=]*)=(.*)".r
    val controls = "\\s*(_controls.*[^=])=(.*)".r
    val br = new BufferedReader(new FileReader(f))
    
    val lines = io.Source.fromFile(f).getLines()
    
    val secname = sec.findFirstMatchIn(lines.next())
    
    var deviceSettings = scala.collection.mutable.Map.empty[String, DeviceSettings]
    
    var section = ""
    var signalMap = scala.collection.mutable.Map.empty[String, String]
    var guardMap = scala.collection.mutable.Map.empty[String, String]
    var actionMap = scala.collection.mutable.Map.empty[String, String]
    var controlList = List.empty[String]
    var disablingPolicy = scala.collection.mutable.Map.empty[String, String]
    var additionalControlMap = scala.collection.mutable.Map.empty[String, List[String]]
    
    secname match {
      case Some(name) => {section = name.group(1).trim; }
      case None       => {}
    }
    
    for(line <- lines){
      val secname = sec.findFirstMatchIn(line)
      var map = secname match {
        case Some(name) => { //new section begins
          
          deviceSettings(section) = new DeviceSettings(
              section, 
              signalMap.toMap, 
              guardMap.toMap, 
              actionMap.toMap, 
              controlList,
              disablingPolicy.toMap,
              additionalControlMap.toMap)
          
          section = name.group(1).trim
          signalMap = scala.collection.mutable.Map.empty[String, String]
          controlList = List.empty[String]
          disablingPolicy = scala.collection.mutable.Map.empty[String, String]
          guardMap = scala.collection.mutable.Map.empty[String, String]
          actionMap = scala.collection.mutable.Map.empty[String, String]
          additionalControlMap = scala.collection.mutable.Map.empty[String, List[String]]
        }
        case None       => { 
          val m = controls.findFirstMatchIn(line)
          m match { 
            case Some(control) => { //controls found
              val cntrls = control.group(2)
              controlList = cntrls.split(",").map{ _.trim().split(":")(0) }.toList
              disablingPolicy = scala.collection.mutable.Map(cntrls.split(",").map{ x => (x.split(":")(0).trim, x.split(":")(1).trim) }.map{case (k,v) => k -> v}:_*)
            }
            case None          => {
              val m = kv.findFirstMatchIn(line)
              m match {
                case Some(keyval) => { //signal found
                  //key for maps (equal to tasks)
                  val key = keyval.group(1).trim
                  //the value part
                  val valuestring = keyval.group(2).trim
                  //regular expressions for signals, actions, guards and more controls
                  val signalPattern = "^([^/\\^&$]*)".r
                  val guardPattern = "/([^\\^&$]*)".r
                  val actionPattern = "\\^([^\\^/&$]*)".r
                  val additionlControlPattern = "&([^\\^/$]*)".r
                  
                  //search for signal
                  val s = signalPattern.findFirstMatchIn(valuestring)
                  s match {
                    case Some(signal) => {signalMap(key) = signal.group(1)}
                    case None         => {}
                  }
                  //search for action
                  val a = actionPattern.findFirstMatchIn(valuestring)
                  a match {
                    case Some(action) => {actionMap(key) = action.group(1)}
                    case None         => {}
                  }
                  //search for guard
                  val g = guardPattern.findFirstMatchIn(valuestring)
                  g match {
                    case Some(guard)  => {guardMap(key) = guard.group(1)}
                    case None         => {}
                  }
                  //search for additional controls
                  val c = additionlControlPattern.findFirstMatchIn(valuestring)
                  c match {
                    case Some(controls) => { 
                      val ctrls = controls.group(1).split(",")
                      additionalControlMap(key) = ctrls.toList
                    }
                    case None          => {}
                  }
                }
                case None         => {}
              }
            }
          }
          
        }
      }
    }
    
    deviceSettings(section) = new DeviceSettings(section, 
        signalMap.toMap, 
        guardMap.toMap, 
        actionMap.toMap, 
        controlList, 
        disablingPolicy.toMap, 
        additionalControlMap.toMap)
    return deviceSettings.toMap //return immutable map
  }
}