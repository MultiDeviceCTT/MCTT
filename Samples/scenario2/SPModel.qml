import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ApplicationWindow {
    id: spmodel
    minimumWidth: 300
    width: 300
    height: 600
    minimumHeight: 400
    visible: true

    style: ApplicationWindowStyle{
        background: Image{
            source: "images/smartphone.png"
        }
    }

    property int channel

    Rectangle{
        width: parent.width
        height: parent.height
        color: "transparent"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 0.2 * parent.height
        anchors.bottomMargin: 0.2 * parent.height
        anchors.leftMargin: 0.1 * parent.width
        anchors.rightMargin: 0.1 * parent.width

        Column{
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.01
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            width: parent.width

            Button {
                id: onOffButton
                text: "Switch On / Off"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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
                id: chanPlusButton
                text: "Channel +"
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
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

            Row{
                spacing: 5
                height: 30
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    id: channelLabel
                    text: "Channel:"
                    color: "white"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }

                TextField{
                    anchors.verticalCenter: parent.verticalCenter
                    id: channelField
                    placeholderText: "channel"
                }

                Button{
                    anchors.verticalCenter: parent.verticalCenter
                    width: 50
                    id: channelAcceptButton
                    text: "Go"
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

            Text{
                id: tvOffText
                text: "TV is off!"
                font.bold: true
                font.pixelSize: 30
                color: "white"
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function getChannel(){
        channel = parseInt(channelField.text)
        return channel.toString()
    }

    SP{

    }

    TVProxy{
        id: tv

        onHardswitchoffOccured: {
            tvOffText.visible = true
        }

        onHardswitchonOccured: {
            tvOffText.visible = false
        }
    }

    RCProxy{
        id: rc
    }
}

