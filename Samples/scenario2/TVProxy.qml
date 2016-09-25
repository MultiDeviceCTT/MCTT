import QtQuick 2.0
Item {
    signal performchannelupFinishedOccured(string data)
    signal performvolumeupFinishedOccured(string data)
    signal hardswitchoffOccured(string data)
    signal gotochannelFinishedOccured(string data)
    signal standbyFinishedOccured(string data)
    signal performunmuteFinishedOccured(string data)
    signal returnfromstandbyFinishedOccured(string data)
    signal performchanneldownFinishedOccured(string data)
    signal hardswitchonOccured(string data)
    signal performvolumedownFinishedOccured(string data)
    signal performmuteFinishedOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: tvproxy
        onTransitionOccured: {
            switch(method){
                case "performChannelUp_finished_tv": tv.performchannelupFinishedOccured(data); break;
                case "performVolumeUp_finished_tv": tv.performvolumeupFinishedOccured(data); break;
                case "hardSwitchOff_tv": tv.hardswitchoffOccured(data); break;
                case "gotoChannel_finished_tv": tv.gotochannelFinishedOccured(data); break;
                case "standBy_finished_tv": tv.standbyFinishedOccured(data); break;
                case "performUnmute_finished_tv": tv.performunmuteFinishedOccured(data); break;
                case "returnFromStandBy_finished_tv": tv.returnfromstandbyFinishedOccured(data); break;
                case "performChannelDown_finished_tv": tv.performchanneldownFinishedOccured(data); break;
                case "hardSwitchOn_tv": tv.hardswitchonOccured(data); break;
                case "performVolumeDown_finished_tv": tv.performvolumedownFinishedOccured(data); break;
                case "performMute_finished_tv": tv.performmuteFinishedOccured(data); break;
                default: console.log("method not known"); tv.genericSignal(data)
            }
        }
    }
}
