package gui

import scalafx.Includes._
import scalafx.application.JFXApp
import scalafx.application.JFXApp.PrimaryStage
import scalafx.scene.Scene
import scalafx.scene.layout.HBox
import scalafx.scene.control.Button
import scalafx.scene.text.Text
import scalafx.geometry.Insets
import scalafx.scene.layout.VBox
import scalafx.scene.control.TextField
import scalafx.scene.control.ComboBox
import scalafx.scene.control.CheckBox
import scalafx.stage.FileChooser
import scalafx.stage.DirectoryChooser
import java.io.File
import java.io.{BufferedReader, FileReader}

import mctt.Translator

/**
 * GUI for MCTT-Translator
 * 
 * @author Andreas Wagner
 */
object MainWindow extends JFXApp {
  stage = new PrimaryStage{
    title = "MCTT Translator"
    scene = new Scene{
      width_=(400)
      content = new VBox{
        children = Seq(
          new HBox{
            padding = Insets(10)
            spacing = 10
            children = Seq(
              new Button{
                text = "Select MCTT file"
                onAction = handle{
                  val chooser = new FileChooser{
                    title = "Select MCTT file"
                    
                  }
                  val mcttfile = chooser.showOpenDialog(stage.scene().window())
                  if (mcttfile != null){
                    val label = stage.scene().lookup("#mcttPathLabel").asInstanceOf[javafx.scene.text.Text]
                    label.text_=(mcttfile.getAbsolutePath)
                  }
                }
              },
              new Text{
                id = "mcttPathLabel"
                text = ""
              }
            )
          },
          new HBox{
            padding = Insets(10)
            spacing = 10
            children = Seq(
              new Button{
                text = "Select Output Folder"
                onAction = handle{
                  val chooser = new DirectoryChooser{
                    title = "Select export directory"
                    
                  }
                  val directory = chooser.showDialog(stage.scene().window())
                  if (directory != null){
                    val label = stage.scene().lookup("#pathLabel").asInstanceOf[javafx.scene.text.Text]
                    label.text_=(directory.getAbsolutePath)
                  }
                }
              },
              new Text{
                id = "pathLabel"
                text = ""
              }
            )
          },
          new HBox{
            padding = Insets(10)
            spacing = 10
            children = Seq(
              new Button{
                text = "Select Mapping File"
                onAction = handle{
                  val chooser = new FileChooser{
                    title = "Select Mapping File"
                    
                  }
                  val file = chooser.showOpenDialog(stage.scene().window())
                  if (file != null){
                    val label = stage.scene().lookup("#mappingLabel").asInstanceOf[javafx.scene.text.Text]
                    label.text_=(file.getAbsolutePath)
                  }
                }
              },
              new Text{
                id = "mappingLabel"
                text = ""
              }
            )
          },
          new HBox{
            padding = Insets(10)
            spacing = 10
            children = Seq(
              new CheckBox{
                id = "isscxml"
                text = "SCXML"
              },
              new CheckBox{
                id = "isqml"
                text = "QML"
              },
              new CheckBox{
                id = "isdebug"
                text = "With Debug Output"
              }
            )
          },
          new HBox{
            padding = Insets(10)
            spacing = 10
            children = Seq(
              new Button{
                text = "Generate"
                onAction = handle {
                  val statuslabel = stage.scene().lookup("#statusLabel").asInstanceOf[javafx.scene.text.Text]
                  statuslabel.text.value = ""
                  
                  val mcttpath = stage.scene().lookup("#mcttPathLabel").asInstanceOf[javafx.scene.text.Text].text.value
                  
                  val source = io.Source.fromFile(new File(mcttpath))
                  val mctt = source.getLines().mkString
                  source.close
    
                  val qml = stage.scene().lookup("#isqml").asInstanceOf[javafx.scene.control.CheckBox].selected.value
                  val debug = stage.scene().lookup("#isdebug").asInstanceOf[javafx.scene.control.CheckBox].selected.value
                  val scxml = stage.scene().lookup("#isscxml").asInstanceOf[javafx.scene.control.CheckBox].selected.value
                  val output = stage.scene().lookup("#pathLabel").asInstanceOf[javafx.scene.text.Text].text.value
                  val mapping = stage.scene().lookup("#mappingLabel").asInstanceOf[javafx.scene.text.Text].text.value
                  
                  Translator.translate(mctt, new File(output), new File(mapping), scxml, qml, debug)
                  
                  statuslabel.text.value = "Generation finished!"
                }
              },
              new Text{
                id = "statusLabel"
                text = ""
              }
            )
          }
        )
      }
    }
  }
}