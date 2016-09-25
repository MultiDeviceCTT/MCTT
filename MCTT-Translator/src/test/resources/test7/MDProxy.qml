import QtQuick 2.0
Item {
    signal selectpizzaOccured(string data)
    signal confirmpizzaselectionOccured(string data)
    signal showconfigFinishedOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: mdproxy
        onTransitionOccured: {
            switch(method){
                case "selectPizza_md": md.selectpizzaOccured(data); break;
                case "confirmPizzaSelection_md": md.confirmpizzaselectionOccured(data); break;
                case "showConfig_finished_md": md.showconfigFinishedOccured(data); break;
                default: console.log("method not known"); md.genericSignal(data)
            }
        }
    }
}
