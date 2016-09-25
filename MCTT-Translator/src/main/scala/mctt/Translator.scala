package mctt

import java.io.File
import mctt.preprocessing._
import mctt.statemachine._
import mctt.emitter.scxml._
import mctt.emitter.qml._

/**
 * Entry object which initiates the translation process
 * 
 * @author Andreas Wagner
 */
object Translator {
  def translate(mctt: String, 
      outdirectory: File,
      mappingFile: File,
      generateSCXML: Boolean, 
      generateQML: Boolean,
      debug: Boolean) = {
    
    if (!outdirectory.exists()){ // create directory if not exists
      outdirectory.mkdir()
    }
    //parse mctt string
    val tree = new Parser().eval(mctt)
    //preprocessing
    val labelset = LabelCollector.collect(tree)
    ActivatedByAnnotator.annotate(tree)
    
    //now translate for each device
    val machines = for((x,y) <- (labelset.toList.zipWithIndex)) yield {
      //annotate
      val (newTree, taskMap) = LabelAnnotator.annotate(tree, x, Set(), Set())
      val machineId = x.toString()

      //translate
      val (init, states, fin) = StateMachineBuilder.build(machineId, labelset, newTree, machineId)
      new Tuple4(machineId, init, states, fin)
    }
    
    //dump everything according to parameters
    //first SCXML
    if(generateSCXML) {
      machines.foreach{machine =>
        val machineId = machine._1
        val init = machine._2
        val states = machine._3
        val fin = machine._4
      
        SM2SCXML.dump(init.head, outdirectory, s"${machineId}.scxml")
      }
    }
    //now QML
    if(generateQML) {
      val settings = MappingParser.load(mappingFile)
      machines.foreach{machine =>
        val machineId = machine._1
        val init = machine._2
        val states = machine._3
        val fin = machine._4
        
        SM2QML.dump(init.head, outdirectory, s"${machineId.toUpperCase()}.qml", settings(machineId), debug)
      }
    }
    
    if(generateSCXML){
      //build a composed SCXML file
      //must be last action as it modifies parent set of the distinct machines!
      val parallelMachine = StateMachineBuilder.buildParallel(machines.map{ m => (m._2, m._3, m._4)}, labelset)
      SM2SCXML.dump(parallelMachine, outdirectory, "system.scxml")
    }
  }
}