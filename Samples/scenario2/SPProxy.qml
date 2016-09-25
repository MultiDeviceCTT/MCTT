import QtQuick 2.0
Item {
    signal unmuteOccured(string data)
    signal volumedownOccured(string data)
    signal volumeupOccured(string data)
    signal muteOccured(string data)
    signal channelselectOccured(string data)
    signal channeldownOccured(string data)
    signal softswitchoffOccured(string data)
    signal channelupOccured(string data)
    signal softswitchonOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: spproxy
        onTransitionOccured: {
            switch(method){
                case "unmute_sp": sp.unmuteOccured(data); break;
                case "volumeDown_sp": sp.volumedownOccured(data); break;
                case "volumeUp_sp": sp.volumeupOccured(data); break;
                case "mute_sp": sp.muteOccured(data); break;
                case "channelSelect_sp": sp.channelselectOccured(data); break;
                case "channelDown_sp": sp.channeldownOccured(data); break;
                case "softSwitchOff_sp": sp.softswitchoffOccured(data); break;
                case "channelUp_sp": sp.channelupOccured(data); break;
                case "softSwitchOn_sp": sp.softswitchonOccured(data); break;
                default: console.log("method not known"); sp.genericSignal(data)
            }
        }
    }
}
