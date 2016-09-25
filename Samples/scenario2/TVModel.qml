import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ApplicationWindow {
    id: tvmodel
    minimumWidth: 600
    width: 600
    height: 400
    minimumHeight: 400
    visible: true

    style: ApplicationWindowStyle{
        background: Image{
            source: "images/tv.png"
        }
    }

    property int channel: 0
    property int volume: 0
    property int tmpVolume
    property int desiredChannel

    Rectangle{
        id: screen
        color: "gray"
        width: parent.width * 0.95
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.75
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.025
    }

    Rectangle{
        id: standByLight
        color: "white"
        width: 15
        height: 15
        radius: width * 0.5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: parent.width * 0.02
        anchors.bottomMargin: parent.height * 0.13
    }

    Button{
        id: onOffButton
        text: "On / Off"
        anchors.right: standByLight.left
        anchors.bottom: standByLight.bottom
        anchors.bottomMargin: -5
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

    FontLoader{
        id: lcdFont
        source: "images/ds_digital/DS-DIGI.TTF"
    }

    Row{
        anchors.bottom: standByLight.bottom
        anchors.bottomMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 20
        spacing: 5
        Label{
            id: textlabel
            text: "Channel"
            color: "white"
            font.pointSize: 20
        }

        Label{
            id: channelLabel
            text: channel
            width: 10
            color: "red"
            font.family: lcdFont.name
            font.pointSize: 25
            font.bold: true
        }

        Label{
            id: textlabel2
            text: "Volume"
            color: "white"
            font.pointSize: 20
        }

        Label{
            id: volumeLabel
            text: volume
            width: 10
            color: "red"
            font.family: lcdFont.name
            font.pointSize: 25
            font.bold: true
        }
    }

    /*
      utility function
    */
    function randomScreenColor(){
        var r = Math.random()
        var g = Math.random()
        var b = Math.random()
        return Qt.rgba(r,g,b,1)
    }

    function volumeUp(cb){
        if(volume < 100) volume++
        cb()
    }

    function volumeDown(cb){
        if(volume > 0) volume--
        cb()
    }

    function channelUp(cb){
        if(channel < 100){
            channel++
            screen.color = randomScreenColor()
        }
        cb()
    }

    function channelDown(cb){
        if(channel > 0){
            channel--
            screen.color = randomScreenColor()
        }
        cb()
    }

    function setChannel(cb){
        if(desiredChannel >= 0 && desiredChannel <= 100)
            channel = desiredChannel
        cb()
    }

    function switchOff(){
        screen.color = "black"
        standByLight.color = "black"
    }

    function switchOn(){
        screen.color = "gray"
        standByLight.color = "white"
    }

    function standBy(cb){
        screen.color = "black"
        standByLight.color = "red"
        cb()
    }

    function returnFromStandBy(cb){
        standByLight.color = "white"
        screen.color = "gray"
        cb()
    }

    function mute(cb){
        tmpVolume = volume
        volume = 0
        cb()
    }

    function unmute(cb){
        volume = tmpVolume
        cb()
    }

    TV{

    }

    SPProxy{
        id: sp
        onChannelselectOccured: {
            desiredChannel = data
        }
    }

    RCProxy{
        id: rc
    }


}

