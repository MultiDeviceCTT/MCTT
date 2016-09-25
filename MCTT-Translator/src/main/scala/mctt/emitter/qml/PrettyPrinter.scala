package mctt.emitter.qml

import java.io.{File, PrintWriter}
/**
 * Helper class for indentation printing
 * 
 * @author Andreas Wagner
 */
class PrettyPrinter(f: File) extends PrintWriter(f){
  var indent = 0
  
  override def print(s: String) = {
    if(s.contains("}")) indent -= 4
    var toprint = " " * indent + s
    super.print(toprint)
    if(s.contains("{")) indent += 4
  }
}