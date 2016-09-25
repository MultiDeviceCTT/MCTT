import QtQuick 2.0
Item {
    signal setpowerOccured(string data)
    signal selectcookingmodeOccured(string data)
    signal confirmpizzaselectionOccured(string data)
    signal selectpizzaOccured(string data)
    signal showconfigFinishedOccured(string data)
    signal cookFinishedOccured(string data)
    signal defrostFinishedOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: mwproxy
        onTransitionOccured: {
            switch(method){
                case "setPower_mw": mw.setpowerOccured(data); break;
                case "selectCookingMode_mw": mw.selectcookingmodeOccured(data); break;
                case "confirmPizzaSelection_mw": mw.confirmpizzaselectionOccured(data); break;
                case "selectPizza_mw": mw.selectpizzaOccured(data); break;
                case "showConfig_finished_mw": mw.showconfigFinishedOccured(data); break;
                case "cook_finished_mw": mw.cookFinishedOccured(data); break;
                case "defrost_finished_mw": mw.defrostFinishedOccured(data); break;
                default: console.log("method not known"); mw.genericSignal(data)
            }
        }
    }
}
