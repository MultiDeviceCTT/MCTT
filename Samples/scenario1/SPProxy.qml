import QtQuick 2.0
Item {
    signal confirmmanualalarmOccured(string data)
    signal choosepizzaOccured(string data)
    signal setpowerOccured(string data)
    signal notifypizzafinishedFinishedOccured(string data)
    signal confirmpizzaalarmOccured(string data)
    signal confirmOccured(string data)
    signal selectfishOccured(string data)
    signal showconfigurationFinishedOccured(string data)
    signal selectpizzaOccured(string data)
    signal setsecondsOccured(string data)
    signal confirmselectedpizzaOccured(string data)
    signal notifyfishfinishedFinishedOccured(string data)
    signal notifymanualfinishedFinishedOccured(string data)
    signal selectautomaticmodeOccured(string data)
    signal setminutesOccured(string data)
    signal confirmfishalarmOccured(string data)
    signal resetOccured(string data)
    signal selectmanualOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: spproxy
        onTransitionOccured: {
            switch(method){
                case "confirmManualAlarm_sp": sp.confirmmanualalarmOccured(data); break;
                case "choosePizza_sp": sp.choosepizzaOccured(data); break;
                case "setPower_sp": sp.setpowerOccured(data); break;
                case "notifyPizzaFinished_finished_sp": sp.notifypizzafinishedFinishedOccured(data); break;
                case "confirmPizzaAlarm_sp": sp.confirmpizzaalarmOccured(data); break;
                case "confirm_sp": sp.confirmOccured(data); break;
                case "selectFish_sp": sp.selectfishOccured(data); break;
                case "showConfiguration_finished_sp": sp.showconfigurationFinishedOccured(data); break;
                case "selectPizza_sp": sp.selectpizzaOccured(data); break;
                case "setSeconds_sp": sp.setsecondsOccured(data); break;
                case "confirmSelectedPizza_sp": sp.confirmselectedpizzaOccured(data); break;
                case "notifyFishFinished_finished_sp": sp.notifyfishfinishedFinishedOccured(data); break;
                case "notifyManualFinished_finished_sp": sp.notifymanualfinishedFinishedOccured(data); break;
                case "selectAutomaticMode_sp": sp.selectautomaticmodeOccured(data); break;
                case "setMinutes_sp": sp.setminutesOccured(data); break;
                case "confirmFishAlarm_sp": sp.confirmfishalarmOccured(data); break;
                case "reset_sp": sp.resetOccured(data); break;
                case "selectManual_sp": sp.selectmanualOccured(data); break;
                default: console.log("method not known"); sp.genericSignal(data)
            }
        }
    }
}
