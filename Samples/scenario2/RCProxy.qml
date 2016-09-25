import QtQuick 2.0
Item {
    signal unmuteOccured(string data)
    signal volumedownOccured(string data)
    signal volumeupOccured(string data)
    signal muteOccured(string data)
    signal channeldownOccured(string data)
    signal softswitchoffOccured(string data)
    signal channelupOccured(string data)
    signal softswitchonOccured(string data)
    signal genericSignal(string data)
    Connections {
        target: rcproxy
        onTransitionOccured: {
            switch(method){
                case "unmute_rc": rc.unmuteOccured(data); break;
                case "volumeDown_rc": rc.volumedownOccured(data); break;
                case "volumeUp_rc": rc.volumeupOccured(data); break;
                case "mute_rc": rc.muteOccured(data); break;
                case "channelDown_rc": rc.channeldownOccured(data); break;
                case "softSwitchOff_rc": rc.softswitchoffOccured(data); break;
                case "channelUp_rc": rc.channelupOccured(data); break;
                case "softSwitchOn_rc": rc.softswitchonOccured(data); break;
                default: console.log("method not known"); rc.genericSignal(data)
            }
        }
    }
}
