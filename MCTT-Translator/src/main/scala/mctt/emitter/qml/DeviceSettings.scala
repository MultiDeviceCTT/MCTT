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

/**
 * Container class for device settings
 * @author: Andreas Wagner
 */
class DeviceSettings(device: String, 
    signals: Map[String, String], guards: Map[String, String], 
    actions: Map[String, String], controls: List[String], 
    disablingPolicy: Map[String, String],
    controlsForTask: Map[String, List[String]]){
  val Name = device
  val SignalMap = signals
  val GuardMap = guards
  val ActionMap = actions
  val UIControls = controls
  val DisablingPolicy = disablingPolicy
  val ControlsForTask = controlsForTask
}