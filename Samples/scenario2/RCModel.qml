import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ApplicationWindow {
    id: rcmodel
    minimumWidth: 210
    width: 210
    height: 500
    minimumHeight: 300
    visible: true

    style: ApplicationWindowStyle{
        background: Image{
            source: "images/remote.png"
        }
    }

    Rectangle{
        width: parent.width * 0.9
        height: parent.height * 0.8
        anchors.centerIn: parent
        color: "transparent"
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 1

        Button {
            id: onOffButton
            width: 35
            height: 35
            style: ButtonStyle{
                label: Rectangle{
                    color: "red"
                    radius: 0.5 * height
                }
            }

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0.1 * parent.width
        }

        Button {
            id: chanPlusButton
            text: "Channel +"
            antialiasing: true
            scale: 1
            anchors.topMargin: 122
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            style: ButtonStyle {
                  label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    //font.family: "Helvetica"
                    font.pointSize: 30
                    color: "black"
                    text: control.text
                  }
                }
        }

        Button {
            id: chanMinusButton
            text: "Channel -"
            scale: 1
            anchors.top: volPlusButton.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            style: ButtonStyle {
                  label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    //font.family: "Helvetica"
                    font.pointSize: 30
                    color: "black"
                    text: control.text
                  }
                }
        }

        Button {
            id: muteButton
            text: "Mute"
            scale: 1
            anchors.top: chanPlusButton.bottom
            anchors.bottom: chanMinusButton.top
            anchors.left: volMinusButton.right
            anchors.right: volPlusButton.left
            style: ButtonStyle {
                  label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    //font.family: "Helvetica"
                    font.pointSize: 30
                    color: "black"
                    text: control.text
                  }
                }
        }

        Button {
            id: volMinusButton
            text: "Vol -"
            scale: 1
            anchors.top: chanPlusButton.bottom
            anchors.right: chanPlusButton.left
            anchors.rightMargin: -25
            style: ButtonStyle {
                  label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    //font.family: "Helvetica"
                    font.pointSize: 30
                    color: "black"
                    text: control.text
                  }
                }
        }

        Button {
            id: volPlusButton
            text: "Vol +"
            scale: 1
            anchors.top: chanPlusButton.bottom
            anchors.left: chanPlusButton.right
            anchors.leftMargin: -25
            style: ButtonStyle {
                  label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    //font.family: "Helvetica"
                    font.pointSize: 30
                    color: "black"
                    text: control.text
                  }
                }
        }
    }

    RC{

    }

    TVProxy{
        id: tv
    }

    SPProxy{
        id: sp
    }
}

