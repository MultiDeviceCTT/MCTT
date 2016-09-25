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