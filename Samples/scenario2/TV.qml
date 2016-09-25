import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_tv
    initialState: comp_896_a_tv_tv
    //activate state machine
    running: true
    State {
        id: comp_896_a_tv_tv
        initialState: comp_e0a_b_tv_tv
        SignalTransition {
            targetState: final_6f3_b_tv_tv
            signal: comp_896_a_tv_tv.finished
        }
        SignalTransition {
            targetState: hardSwitchOff_finished_tv_tv_47c_a
            signal: onOffButton.clicked
            guard: local.hasLock()
            onTriggered: {
                var data = tvmodel.switchOff()
                local.broadcastTransition("hardSwitchOff_tv", data)
                local.release()
            }
        }
        onEntered: {
            console.log("tv: comp_896_a_tv_tv entered")
            //update UI
            onOffButton.enabled = true
        }
        onExited: {
            console.log("tv: comp_896_a_tv_tv exited")
            onOffButton.enabled = false
        }
        State {
            id: comp_e0a_b_tv_tv
            initialState: init_870_9_tv_tv
            SignalTransition {
                targetState: final_431_8_tv_tv
                signal: comp_e0a_b_tv_tv.finished
            }
            SignalTransition {
                targetState: standBy_tv_tv_ef1_b
                signal: sp.softswitchoffOccured // softSwitchOff_sp
            }
            SignalTransition {
                targetState: standBy_tv_tv_ef1_b
                signal: rc.softswitchoffOccured // softSwitchOff_rc
            }
            onEntered: {
                console.log("tv: comp_e0a_b_tv_tv entered")
                //update UI
                onOffButton.enabled = true
            }
            onExited: {
                console.log("tv: comp_e0a_b_tv_tv exited")
            }
            State {
                id: init_870_9_tv_tv
                SignalTransition {
                    targetState: performChannelDown_tv_tv_r_fd7_8
                    signal: rc.channeldownOccured // channelDown_rc
                }
                SignalTransition {
                    targetState: gotoChannel_tv_tv_r_5be_9
                    signal: sp.channelselectOccured // channelSelect_sp
                }
                SignalTransition {
                    targetState: performChannelUp_tv_tv_r_3a3_a
                    signal: sp.channelupOccured // channelUp_sp
                }
                SignalTransition {
                    targetState: performVolumeUp_tv_tv_l_7fb_8
                    signal: rc.volumeupOccured // volumeUp_rc
                }
                SignalTransition {
                    targetState: performChannelUp_tv_tv_r_3a3_a
                    signal: rc.channelupOccured // channelUp_rc
                }
                SignalTransition {
                    targetState: performMute_tv_tv_l_772_8
                    signal: rc.muteOccured // mute_rc
                }
                SignalTransition {
                    targetState: performChannelDown_tv_tv_r_fd7_8
                    signal: sp.channeldownOccured // channelDown_sp
                }
                SignalTransition {
                    targetState: performVolumeDown_tv_tv_l_cf6_b
                    signal: sp.volumedownOccured // volumeDown_sp
                }
                SignalTransition {
                    targetState: performMute_tv_tv_l_772_8
                    signal: sp.muteOccured // mute_sp
                }
                SignalTransition {
                    targetState: performVolumeUp_tv_tv_l_7fb_8
                    signal: sp.volumeupOccured // volumeUp_sp
                }
                SignalTransition {
                    targetState: performVolumeDown_tv_tv_l_cf6_b
                    signal: rc.volumedownOccured // volumeDown_rc
                }
                onEntered: {
                    console.log("tv: init_870_9_tv_tv entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("tv: init_870_9_tv_tv exited")
                }
            }
            State {
                id: par_818_8_tv
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_17d_8_tv_tv
                    signal: par_818_8_tv.finished
                }
                onEntered: {
                    console.log("tv: par_818_8_tv entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("tv: par_818_8_tv exited")
                }
                State {
                    id: comp_652_a_tv_tv
                    initialState: init_513_b_tv_tv_r
                    onEntered: {
                        console.log("tv: comp_652_a_tv_tv entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("tv: comp_652_a_tv_tv exited")
                    }
                    State {
                        id: init_513_b_tv_tv_r
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_r_832_8
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_r_b58_8
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_r_ee8_b
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_r_b58_8
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_r_832_8
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_r_ee8_b
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("tv_r: init_513_b_tv_tv_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r: init_513_b_tv_tv_r exited")
                        }
                    }
                    State {
                        id: performVolumeUp_tv_tv_r_832_8
                        SignalTransition {
                            targetState: loop_2a5_a_tv_tv_r
                            signal: performvolumeupFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_832_8: performVolumeUp_tv_tv_r_832_8 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.volumeUp(performVolumeUp_callback)
                        }
                        onExited: {
                            console.log("tv_r_832_8: performVolumeUp_tv_tv_r_832_8 exited")
                        }
                    }
                    State {
                        id: loop_2a5_a_tv_tv_r
                        SignalTransition {
                            targetState: final_b89_8_tv_tv_r
                            signal: loop2a5AFinished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_r_832_8
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_r_b58_8
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_r_ee8_b
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_r_b58_8
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_r_832_8
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_r_ee8_b
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("tv_r: loop_2a5_a_tv_tv_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r: loop_2a5_a_tv_tv_r exited")
                        }
                    }
                    FinalState {
                        id: final_b89_8_tv_tv_r
                        onEntered: {
                            console.log("tv_r: final_b89_8_tv_tv_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r: final_b89_8_tv_tv_r exited")
                        }
                    }
                    State {
                        id: performMute_tv_tv_r_b58_8
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_tv_r_b58_8
                            signal: performmuteFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_b58_8: performMute_tv_tv_r_b58_8 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.mute(performMute_callback)
                        }
                        onExited: {
                            console.log("tv_r_b58_8: performMute_tv_tv_r_b58_8 exited")
                        }
                    }
                    State {
                        id: performMute_finished_finished_tv_tv_r_b58_8
                        SignalTransition {
                            targetState: performUnmute_tv_tv_r_cde_b
                            signal: sp.unmuteOccured // unmute_sp
                        }
                        SignalTransition {
                            targetState: performUnmute_tv_tv_r_cde_b
                            signal: rc.unmuteOccured // unmute_rc
                        }
                        onEntered: {
                            console.log("tv_r_b58_8: performMute_finished_finished_tv_tv_r_b58_8 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r_b58_8: performMute_finished_finished_tv_tv_r_b58_8 exited")
                        }
                    }
                    State {
                        id: performUnmute_tv_tv_r_cde_b
                        SignalTransition {
                            targetState: loop_2a5_a_tv_tv_r
                            signal: performunmuteFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_cde_b: performUnmute_tv_tv_r_cde_b entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.unmute(performUnmute_callback)
                        }
                        onExited: {
                            console.log("tv_r_cde_b: performUnmute_tv_tv_r_cde_b exited")
                        }
                    }
                    State {
                        id: performVolumeDown_tv_tv_r_ee8_b
                        SignalTransition {
                            targetState: loop_2a5_a_tv_tv_r
                            signal: performvolumedownFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_ee8_b: performVolumeDown_tv_tv_r_ee8_b entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.volumeDown(performVolumeDown_callback)
                        }
                        onExited: {
                            console.log("tv_r_ee8_b: performVolumeDown_tv_tv_r_ee8_b exited")
                        }
                    }
                }
                State {
                    id: comp_446_a_tv_tv
                    initialState: performChannelUp_tv_tv_r_3a3_a
                    onEntered: {
                        console.log("tv: comp_446_a_tv_tv entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("tv: comp_446_a_tv_tv exited")
                    }
                    State {
                        id: performChannelUp_tv_tv_r_3a3_a
                        SignalTransition {
                            targetState: loop_e82_b_tv_tv_r
                            signal: performchannelupFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_3a3_a: performChannelUp_tv_tv_r_3a3_a entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.channelUp(performChannelUp_callback)
                        }
                        onExited: {
                            console.log("tv_r_3a3_a: performChannelUp_tv_tv_r_3a3_a exited")
                        }
                    }
                    State {
                        id: loop_e82_b_tv_tv_r
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_r_fd7_8
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: gotoChannel_tv_tv_r_5be_9
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_r_3a3_a
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_r_3a3_a
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_r_fd7_8
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        SignalTransition {
                            targetState: final_d22_9_tv_tv_r
                            signal: loopE82BFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r: loop_e82_b_tv_tv_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r: loop_e82_b_tv_tv_r exited")
                        }
                    }
                    State {
                        id: performChannelDown_tv_tv_r_fd7_8
                        SignalTransition {
                            targetState: loop_e82_b_tv_tv_r
                            signal: performchanneldownFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_fd7_8: performChannelDown_tv_tv_r_fd7_8 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.channelDown(performChannelDown_callback)
                        }
                        onExited: {
                            console.log("tv_r_fd7_8: performChannelDown_tv_tv_r_fd7_8 exited")
                        }
                    }
                    State {
                        id: gotoChannel_tv_tv_r_5be_9
                        SignalTransition {
                            targetState: loop_e82_b_tv_tv_r
                            signal: gotochannelFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_r_5be_9: gotoChannel_tv_tv_r_5be_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.setChannel(gotoChannel_callback)
                        }
                        onExited: {
                            console.log("tv_r_5be_9: gotoChannel_tv_tv_r_5be_9 exited")
                        }
                    }
                    FinalState {
                        id: final_d22_9_tv_tv_r
                        onEntered: {
                            console.log("tv_r: final_d22_9_tv_tv_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_r: final_d22_9_tv_tv_r exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_17d_8_tv_tv
                onEntered: {
                    console.log("tv: final_17d_8_tv_tv entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("tv: final_17d_8_tv_tv exited")
                }
            }
            State {
                id: par_bbf_8_tv
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_17d_8_tv_tv
                    signal: par_bbf_8_tv.finished
                }
                onEntered: {
                    console.log("tv: par_bbf_8_tv entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("tv: par_bbf_8_tv exited")
                }
                State {
                    id: comp_952_b_tv_tv
                    initialState: performMute_finished_finished_tv_tv_l_772_8
                    onEntered: {
                        console.log("tv: comp_952_b_tv_tv entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("tv: comp_952_b_tv_tv exited")
                    }
                    State {
                        id: performMute_finished_finished_tv_tv_l_772_8
                        SignalTransition {
                            targetState: performUnmute_tv_tv_l_1b8_9
                            signal: sp.unmuteOccured // unmute_sp
                        }
                        SignalTransition {
                            targetState: performUnmute_tv_tv_l_1b8_9
                            signal: rc.unmuteOccured // unmute_rc
                        }
                        onEntered: {
                            console.log("tv_l_772_8: performMute_finished_finished_tv_tv_l_772_8 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l_772_8: performMute_finished_finished_tv_tv_l_772_8 exited")
                        }
                    }
                    State {
                        id: performUnmute_tv_tv_l_1b8_9
                        SignalTransition {
                            targetState: loop_cff_9_tv_tv_l
                            signal: performunmuteFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_1b8_9: performUnmute_tv_tv_l_1b8_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.unmute(performUnmute_callback)
                        }
                        onExited: {
                            console.log("tv_l_1b8_9: performUnmute_tv_tv_l_1b8_9 exited")
                        }
                    }
                    State {
                        id: loop_cff_9_tv_tv_l
                        SignalTransition {
                            targetState: final_c92_8_tv_tv_l
                            signal: loopCff9Finished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_l_7fb_8
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_l_772_8
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_l_cf6_b
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: performMute_tv_tv_l_772_8
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: performVolumeUp_tv_tv_l_7fb_8
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: performVolumeDown_tv_tv_l_cf6_b
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("tv_l: loop_cff_9_tv_tv_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l: loop_cff_9_tv_tv_l exited")
                        }
                    }
                    FinalState {
                        id: final_c92_8_tv_tv_l
                        onEntered: {
                            console.log("tv_l: final_c92_8_tv_tv_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l: final_c92_8_tv_tv_l exited")
                        }
                    }
                    State {
                        id: performVolumeUp_tv_tv_l_7fb_8
                        SignalTransition {
                            targetState: loop_cff_9_tv_tv_l
                            signal: performvolumeupFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_7fb_8: performVolumeUp_tv_tv_l_7fb_8 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.volumeUp(performVolumeUp_callback)
                        }
                        onExited: {
                            console.log("tv_l_7fb_8: performVolumeUp_tv_tv_l_7fb_8 exited")
                        }
                    }
                    State {
                        id: performMute_tv_tv_l_772_8
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_tv_l_772_8
                            signal: performmuteFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_772_8: performMute_tv_tv_l_772_8 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.mute(performMute_callback)
                        }
                        onExited: {
                            console.log("tv_l_772_8: performMute_tv_tv_l_772_8 exited")
                        }
                    }
                    State {
                        id: performVolumeDown_tv_tv_l_cf6_b
                        SignalTransition {
                            targetState: loop_cff_9_tv_tv_l
                            signal: performvolumedownFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_cf6_b: performVolumeDown_tv_tv_l_cf6_b entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.volumeDown(performVolumeDown_callback)
                        }
                        onExited: {
                            console.log("tv_l_cf6_b: performVolumeDown_tv_tv_l_cf6_b exited")
                        }
                    }
                }
                State {
                    id: comp_656_b_tv_tv
                    initialState: init_8d5_b_tv_tv_l
                    onEntered: {
                        console.log("tv: comp_656_b_tv_tv entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("tv: comp_656_b_tv_tv exited")
                    }
                    State {
                        id: init_8d5_b_tv_tv_l
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_l_aaf_9
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: gotoChannel_tv_tv_l_91f_9
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_l_49c_9
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_l_49c_9
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_l_aaf_9
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        onEntered: {
                            console.log("tv_l: init_8d5_b_tv_tv_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l: init_8d5_b_tv_tv_l exited")
                        }
                    }
                    State {
                        id: performChannelDown_tv_tv_l_aaf_9
                        SignalTransition {
                            targetState: loop_018_8_tv_tv_l
                            signal: performchanneldownFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_aaf_9: performChannelDown_tv_tv_l_aaf_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.channelDown(performChannelDown_callback)
                        }
                        onExited: {
                            console.log("tv_l_aaf_9: performChannelDown_tv_tv_l_aaf_9 exited")
                        }
                    }
                    State {
                        id: loop_018_8_tv_tv_l
                        SignalTransition {
                            targetState: final_05e_9_tv_tv_l
                            signal: loop0188Finished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_l_aaf_9
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: gotoChannel_tv_tv_l_91f_9
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_l_49c_9
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: performChannelUp_tv_tv_l_49c_9
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: performChannelDown_tv_tv_l_aaf_9
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        onEntered: {
                            console.log("tv_l: loop_018_8_tv_tv_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l: loop_018_8_tv_tv_l exited")
                        }
                    }
                    FinalState {
                        id: final_05e_9_tv_tv_l
                        onEntered: {
                            console.log("tv_l: final_05e_9_tv_tv_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("tv_l: final_05e_9_tv_tv_l exited")
                        }
                    }
                    State {
                        id: gotoChannel_tv_tv_l_91f_9
                        SignalTransition {
                            targetState: loop_018_8_tv_tv_l
                            signal: gotochannelFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_91f_9: gotoChannel_tv_tv_l_91f_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.setChannel(gotoChannel_callback)
                        }
                        onExited: {
                            console.log("tv_l_91f_9: gotoChannel_tv_tv_l_91f_9 exited")
                        }
                    }
                    State {
                        id: performChannelUp_tv_tv_l_49c_9
                        SignalTransition {
                            targetState: loop_018_8_tv_tv_l
                            signal: performchannelupFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("tv_l_49c_9: performChannelUp_tv_tv_l_49c_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            //execute hooks, i.e. actual behavior code
                            tvmodel.channelUp(performChannelUp_callback)
                        }
                        onExited: {
                            console.log("tv_l_49c_9: performChannelUp_tv_tv_l_49c_9 exited")
                        }
                    }
                }
            }
        }
        FinalState {
            id: final_431_8_tv_tv
            onEntered: {
                console.log("tv: final_431_8_tv_tv entered")
                //update UI
                onOffButton.enabled = true
            }
            onExited: {
                console.log("tv: final_431_8_tv_tv exited")
            }
        }
        State {
            id: standBy_tv_tv_ef1_b
            SignalTransition {
                targetState: standBy_finished_finished_tv_tv_ef1_b
                signal: standbyFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("tv_ef1_b: standBy_tv_tv_ef1_b entered")
                //update UI
                onOffButton.enabled = true
                //execute hooks, i.e. actual behavior code
                tvmodel.standBy(standBy_callback)
            }
            onExited: {
                console.log("tv_ef1_b: standBy_tv_tv_ef1_b exited")
            }
        }
        State {
            id: standBy_finished_finished_tv_tv_ef1_b
            SignalTransition {
                targetState: returnFromStandBy_tv_tv_63b_b
                signal: sp.softswitchonOccured // softSwitchOn_sp
            }
            SignalTransition {
                targetState: returnFromStandBy_tv_tv_63b_b
                signal: rc.softswitchonOccured // softSwitchOn_rc
            }
            onEntered: {
                console.log("tv_ef1_b: standBy_finished_finished_tv_tv_ef1_b entered")
                //update UI
                onOffButton.enabled = true
            }
            onExited: {
                console.log("tv_ef1_b: standBy_finished_finished_tv_tv_ef1_b exited")
            }
        }
        State {
            id: returnFromStandBy_tv_tv_63b_b
            SignalTransition {
                targetState: comp_e0a_b_tv_tv
                signal: returnfromstandbyFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("tv_63b_b: returnFromStandBy_tv_tv_63b_b entered")
                //update UI
                onOffButton.enabled = true
                //execute hooks, i.e. actual behavior code
                tvmodel.returnFromStandBy(returnFromStandBy_callback)
            }
            onExited: {
                console.log("tv_63b_b: returnFromStandBy_tv_tv_63b_b exited")
            }
        }
    }
    FinalState {
        id: final_6f3_b_tv_tv
        onEntered: {
            console.log("tv: final_6f3_b_tv_tv entered")
            //update UI
        }
        onExited: {
            console.log("tv: final_6f3_b_tv_tv exited")
        }
    }
    State {
        id: hardSwitchOff_finished_tv_tv_47c_a
        SignalTransition {
            targetState: comp_896_a_tv_tv
            signal: onOffButton.clicked
            guard: local.hasLock()
            onTriggered: {
                var data = tvmodel.switchOn()
                local.broadcastTransition("hardSwitchOn_tv", data)
                local.release()
            }
        }
        onEntered: {
            console.log("tv_47c_a: hardSwitchOff_finished_tv_tv_47c_a entered")
            //update UI
            onOffButton.enabled = true
        }
        onExited: {
            console.log("tv_47c_a: hardSwitchOff_finished_tv_tv_47c_a exited")
            onOffButton.enabled = false
        }
    }
    function performChannelUp_callback(){
        local.broadcastTransition("performChannelUp_finished_tv", "")
        performchannelupFinished()
    }
    function dummy_loop_e82_b_finished_callback(){
        loopE82BFinished()
    }
    function performUnmute_callback(){
        local.broadcastTransition("performUnmute_finished_tv", "")
        performunmuteFinished()
    }
    function returnFromStandBy_callback(){
        local.broadcastTransition("returnFromStandBy_finished_tv", "")
        returnfromstandbyFinished()
    }
    function dummy_loop_cff_9_finished_callback(){
        loopCff9Finished()
    }
    function dummy_loop_018_8_finished_callback(){
        loop0188Finished()
    }
    function performMute_callback(){
        local.broadcastTransition("performMute_finished_tv", "")
        performmuteFinished()
    }
    function dummy_loop_2a5_a_finished_callback(){
        loop2a5AFinished()
    }
    function performChannelDown_callback(){
        local.broadcastTransition("performChannelDown_finished_tv", "")
        performchanneldownFinished()
    }
    function performVolumeUp_callback(){
        local.broadcastTransition("performVolumeUp_finished_tv", "")
        performvolumeupFinished()
    }
    function performVolumeDown_callback(){
        local.broadcastTransition("performVolumeDown_finished_tv", "")
        performvolumedownFinished()
    }
    function gotoChannel_callback(){
        local.broadcastTransition("gotoChannel_finished_tv", "")
        gotochannelFinished()
    }
    function standBy_callback(){
        local.broadcastTransition("standBy_finished_tv", "")
        standbyFinished()
    }
    signal performchannelupFinished
    signal loopE82BFinished
    signal performunmuteFinished
    signal returnfromstandbyFinished
    signal loopCff9Finished
    signal loop0188Finished
    signal performmuteFinished
    signal loop2a5AFinished
    signal performchanneldownFinished
    signal performvolumeupFinished
    signal performvolumedownFinished
    signal gotochannelFinished
    signal standbyFinished
}
