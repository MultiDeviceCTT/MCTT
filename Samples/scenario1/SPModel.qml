import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ApplicationWindow{
    id: spmodel
    width: 250
    height: 500
    visible: true

    style: ApplicationWindowStyle{
        background: Image{
            source: "images/smartphone.png"
        }
    }

    property int minutes
    property int seconds
    property int power
    property int timerSeconds: minutes * 60 + seconds
    property string pizza
    property Image image

    Rectangle{
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.15
        anchors.right: parent.right
        anchors.rightMargin: 0.1 * parent.width
        anchors.left: parent.left
        anchors.leftMargin: 0.1 * parent.width
        color: "transparent"

        ComboBox{
            id: modeCombo
            model: ["auto mode", "manual mode"]
            width: parent.width
            anchors.top: parent.top
            visible: false
        }

        ComboBox{
            id: foodCombo
            model: ["Fish", "Pizza"]
            width: parent.width
            anchors.top: parent.top
            visible: false
        }

        ComboBox{
            id: pizzaCombo
            model: ["Funghi", "Prosciutto", "Mozzarella"]
            width: parent.width
            anchors.top: parent.top
            visible: false
            onVisibleChanged: {
                if(visible === false){
                    mozzarellaImage.visible = false;
                    funghiImage.visible = false;
                    prosciuttoImage.visible = false;
                }
                else{
                    pizzaCombo.currentIndex = 0
                    pizza = pizzaCombo.currentText
                    image = funghiImage
                    funghiImage.visible = true
                }
            }

            onCurrentIndexChanged: {
                if(visible){
                    var index = pizzaCombo.currentIndex
                    pizza = pizzaCombo.currentText
                    switch(index){
                    case 0:
                        mozzarellaImage.visible = false;
                        prosciuttoImage.visible = false;
                        funghiImage.visible = true;
                        image = funghiImage;
                        break;
                    case 1:
                        funghiImage.visible = false;
                        mozzarellaImage.visible = false;
                        prosciuttoImage.visible = true;
                        image = prosciuttoImage;
                        break;
                    case 2:
                        funghiImage.visible = false;
                        prosciuttoImage.visible = false;
                        mozzarellaImage.visible = true;
                        image = mozzarellaImage;
                        break;
                    }
                }
            }
        }

        Image{
            id: funghiImage
            source: "images/funghi.png"
            anchors.top: pizzaCombo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            visible: false
        }

        Image{
            id: mozzarellaImage
            source: "images/mozzarella.png"
            anchors.top: pizzaCombo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            visible: false
        }

        Image{
            id: prosciuttoImage
            source: "images/prosciutto.png"
            anchors.top: pizzaCombo.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            visible: false
        }

        Column{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            TextField{
                id: minInput
                placeholderText: "min"
                visible: false
            }

            TextField{
                id: secInput
                placeholderText: "sec"
                visible: false
            }

            TextField{
                id: powerInput
                placeholderText: "power"
                visible: false
            }
        }

        Image{
            id: bell
            anchors.centerIn: parent
            source: "images/bell.png"
            visible: false

            SequentialAnimation{
                id: bellBlink
                running: false
                loops: Animation.Infinite
                NumberAnimation{
                    target: bell
                    property: "opacity"
                    to: 1
                    duration: 400
                }
                NumberAnimation{
                    target: bell
                    property: "opacity"
                    to: 0
                    duration: 400
                }
            }
        }

        Text{
            id: statusField
            color: "white"
            visible: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            anchors.top: bell.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button{
            id: confirmButton
            text: "Confirm"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        Button{
            id: resetButton
            text: "Reset"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }

    function getSelectedPizza(){
        image.visible = false
        var data = "pizza-" + pizza
        return data
    }

    function showSelectedPizza(){
        image.visible = true
    }

    function getMinutes(){
        minutes = parseInt(minInput.text)
        return minInput.text
    }

    function getSeconds(){
        seconds = parseInt(secInput.text)
        return secInput.text
    }

    function getPower(){
        power = parseInt(powerInput.text)
        return powerInput.text
    }

    function notifyPizzaFinished(cb){
        bellBlink.start()
        statusField.text = "Your Pizza\n" + pizza + "\nis done!"
        //cb()
    }

    function notifyFishFinished(cb){
        bellBlink.start()
        statusField.text = "Fish finished!"
        //cb()
    }

    function showConfiguration(cb){
        statusField.text = "Time: " + timerSeconds + " Seconds\nPower: " + power + " Watts"
        cb()
    }

    function notifyManualFinished(cb){
        bellBlink.start()
        statusField.text = "Cooking finished!"
        //cb()
    }

    function confirmAlarm(){
        bellBlink.stop()
    }

    function confirmConfiguration(){
        var data = minutes.toString() + ";" + seconds.toString() + ";" + power.toString()
        return data
    }

    function reset(){
        funghiImage.visible = false;
        mozzarellaImage.visible = false;
        prosciuttoImage.visible = false;
    }

    SP{

    }

    MWProxy{
        id: mw
        onGenericSignal:{
            console.log("data: " + data)
            var parts = data.split("-")
            switch(parts[0]){
            case "pizza":
                pizza = parts[1]
            }
        }
    }
}
