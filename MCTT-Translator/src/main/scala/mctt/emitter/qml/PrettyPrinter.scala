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