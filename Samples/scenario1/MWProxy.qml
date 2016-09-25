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
    signal bakeFinishedOccured(string data)
    signal selectpizzaOccured(string data)
    signal setsecondsOccured(string data)
    signal confirmselectedpizzaOccured(string data)
    signal notifyfishfinishedFinishedOccured(string data)
    signal disableheaterFinishedOccured(string data)
    signal notifymanualfinishedFinishedOccured(string data)
    signal cookFinishedOccured(string data)
    signal selectautomaticmodeOccured(string data)
    signal countdownFinishedOccured(string data)
    signal setminutesOccured(string data)
    signal enableheaterFinishedOccured(string data)
    signal confirmfishalarmOccured(string data)
    signal resetOccured(string data)
    signal defrostFinishedOccured(string data)
    signal selectmanualOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: mwproxy
        onTransitionOccured: {
            switch(method){
                case "confirmManualAlarm_mw": mw.confirmmanualalarmOccured(data); break;
                case "choosePizza_mw": mw.choosepizzaOccured(data); break;
                case "setPower_mw": mw.setpowerOccured(data); break;
                case "notifyPizzaFinished_finished_mw": mw.notifypizzafinishedFinishedOccured(data); break;
                case "confirmPizzaAlarm_mw": mw.confirmpizzaalarmOccured(data); break;
                case "confirm_mw": mw.confirmOccured(data); break;
                case "selectFish_mw": mw.selectfishOccured(data); break;
                case "showConfiguration_finished_mw": mw.showconfigurationFinishedOccured(data); break;
                case "bake_finished_mw": mw.bakeFinishedOccured(data); break;
                case "selectPizza_mw": mw.selectpizzaOccured(data); break;
                case "setSeconds_mw": mw.setsecondsOccured(data); break;
                case "confirmSelectedPizza_mw": mw.confirmselectedpizzaOccured(data); break;
                case "notifyFishFinished_finished_mw": mw.notifyfishfinishedFinishedOccured(data); break;
                case "disableHeater_finished_mw": mw.disableheaterFinishedOccured(data); break;
                case "notifyManualFinished_finished_mw": mw.notifymanualfinishedFinishedOccured(data); break;
                case "cook_finished_mw": mw.cookFinishedOccured(data); break;
                case "selectAutomaticMode_mw": mw.selectautomaticmodeOccured(data); break;
                case "countdown_finished_mw": mw.countdownFinishedOccured(data); break;
                case "setMinutes_mw": mw.setminutesOccured(data); break;
                case "enableHeater_finished_mw": mw.enableheaterFinishedOccured(data); break;
                case "confirmFishAlarm_mw": mw.confirmfishalarmOccured(data); break;
                case "reset_mw": mw.resetOccured(data); break;
                case "defrost_finished_mw": mw.defrostFinishedOccured(data); break;
                case "selectManual_mw": mw.selectmanualOccured(data); break;
                default: console.log("method not known"); mw.genericSignal(data)
            }
        }
    }
}
