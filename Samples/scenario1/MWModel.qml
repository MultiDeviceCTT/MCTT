import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ApplicationWindow{

    style: ApplicationWindowStyle{
        background: Image{
            source: "images/microwave.png"
        }
    }

    //properties
    property int seconds
    property int minutes
    property int timerSeconds: minutes * 60 + seconds
    property int countdownSeconds
    property int watts
    property string pizza
    property var countdownFinished

    id: mwmodel
    width: 1000
    height: 400
    visible: true

    FontLoader {
        id: lcdFont
        source: "images/ds_digital/DS-DIGI.TTF"
    }

    Rectangle{
        anchors.left: parent.left
        anchors.leftMargin: 0.125 * parent.width
        anchors.top: parent.top
        anchors.topMargin: 0.24 * parent.height
        id: imageArea
        width: parent.width * 0.56
        height: parent.height * 0.46
        color: "black"
    }

    Rectangle{
        id: displayArea
        anchors.top: parent.top
        anchors.topMargin: 0.025 * parent.height
        anchors.right: parent.right
        anchors.rightMargin: 0.008 * parent.width
        width: parent.width * 0.17
        height: parent.height * 0.18
        color: "transparent"

        Text{
            id: lcd
            font.family: lcdFont.name
            anchors.fill: parent
            text: "--"
            color: "green"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: lcd.height * 0.7
        }
    }

    Rectangle{
        anchors.top: displayArea.bottom
        anchors.right: parent.right
        anchors.rightMargin: 0.008 * parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0.05 * parent.height
        width: parent.width * 0.17
        radius: 10
        color: "dimgrey"

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Column{

                spacing: 5

                Button{
                    id: autoButton
                    text: "Automatic Mode"
                    visible: false
                }

                Button{
                    id: manualButton
                    text: "Manual Mode"
                    visible: false
                }
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            Column{
                spacing: 5

                Button{
                    id: pizzaButton
                    text: "Pizza"
                    visible: false
                }

                Button{
                    id: fishButton
                    text: "Fish"
                    visible: false
                }
            }
        }

        Row{
            spacing: 5
            Text{
                id: minInputText
                text: "Minutes"
                visible: false
            }

            SpinBox{
                id: minInput
                minimumValue: 0
                maximumValue: 60
                stepSize: 1
                visible: false
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            Text{
                id: secInputText
                text: "Seconds"
                visible: false
            }

            SpinBox{
                id: secInput
                minimumValue: 0
                maximumValue: 60
                stepSize: 1
                visible: false
            }
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Text{
                id: powerInputText
                text: "Power"
                visible: false
            }

            SpinBox{
                id: powerInput
                minimumValue: 100
                maximumValue: 900
                stepSize: 20
                visible: false
            }
        }

        GroupBox {
            anchors.horizontalCenter: parent.horizontalCenter
            id: pizzaGroupBox
            title: "Select Pizza"
            visible: false
            Column {
                spacing: 20
                ExclusiveGroup { id: pizzaGroup }
                RadioButton {
                    text: "Funghi"
                    exclusiveGroup: pizzaGroup
                    onClicked: pizza = "Funghi"
                }
                RadioButton {
                    text: "Mozzarella"
                    exclusiveGroup: pizzaGroup
                    onClicked: pizza = "Mozzarella"
                }
                RadioButton {
                    text: "Prosciutto"
                    exclusiveGroup: pizzaGroup
                    onClicked: pizza = "Prosciutto"
                }
            }
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            id: confirmButton
            text: "OK"
            enabled: false
        }

        Button{
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            id: resetButton
            text: "Reset"
            enabled: false
        }

        Rectangle{
            id: bell
            color: "red"
            width: 50
            height: 50
            radius: width * 0.5
            visible: false
            anchors.centerIn: parent

            SequentialAnimation{
                id: bellBlink
                running: false
                loops: Animation.Infinite
                NumberAnimation{
                    target: bell
                    property: "opacity"
                    to: 1
                    duration: 500
                }
                NumberAnimation{
                    target: bell
                    property: "opacity"
                    to: 0
                    duration: 500
                }
            }
        }

        Text{
            id: statusField
            anchors.top: bell.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }
    }

    Timer{
        id: countdownTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            countdownSeconds--
            statusField.text = "Cook at " + watts + " Watts"
            lcd.text = countdownSeconds
            if(countdownSeconds == 0) { countdownTimer.stop(); countdownFinished()}
        }
    }


    function defrost(cb){
        countdownFinished = cb
        watts = 150
        minutes = 0
        seconds = 5
        countdownSeconds = timerSeconds
        imageArea.color = "darkorange"
        countdownTimer.start()
    }

    function bake(cb){
        countdownFinished = cb
        watts = 350
        minutes = 0
        seconds = 6
        countdownSeconds = timerSeconds
        console.log( "time: " + timerSeconds)
        imageArea.color = "red"
        countdownTimer.start()
    }

    function choosePizza(){
        statusField.text = "You selected\n" + pizza + ".\nContinue?"
    }

    function pizzaAlarm(cb){
        bellBlink.start()
        statusField.text = "Pizza finished! (" + pizza + ")"
        //cb()
    }

    function cook(cb){
        countdownFinished = cb
        minutes = 0
        seconds = 8
        watts = 420
        countdownSeconds = timerSeconds
        imageArea.color = "red"
        countdownTimer.start()
    }

    function fishAlarm(cb){
        bellBlink.start()
        statusField.text = "Fish finished!"
        //cb()
    }

    function getMinutes(){
        minutes = minInput.value
    }

    function getSeconds(){
        seconds = secInput.value
    }

    function getPower(){
        watts = powerInput.value
    }

    function showConfiguration(cb){
        statusField.text = "Time: " + timerSeconds + " Seconds \nPower: " + watts + " Watts"
        cb()
    }

    function enableHeater(cb){
        imageArea.color = "red"
        cb()
    }

    function countdown(cb){
        countdownFinished = cb
        countdownTimer.start()
        //cb()
    }

    function disableHeater(cb){
        imageArea.color = "black"
        cb()
    }

    function manualAlarm(cb){
        bellBlink.start()
        statusField.text = "Cooking finished!"
        //cb()
    }

    function confirmAlarm(){
        bellBlink.stop()
    }

    function sendPizza(){
        var data = "pizza-" + pizza
        return data
    }

    function reset(){
        bellBlink.stop()
        countdownTimer.stop()
        imageArea.color = "black"
        console.log("Resetting everything")
    }

    MW{

    }

    SPProxy{
        id: sp
        onConfirmOccured:{
            console.log("configuration data received: " + data)
            var parts = data.split(";")
            minutes = parseInt(parts[0])
            seconds = parseInt(parts[1])
            watts = parseInt(parts[2])
            countdownSeconds = timerSeconds
        }

        onConfirmselectedpizzaOccured: {
            var parts = data.split("-")
            switch(parts[0]){
            case "pizza": pizza = parts[1]
            }
        }
    }
}
