import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_rc
    initialState: comp_c40_a_rc_rc
    //activate state machine
    running: true
    State {
        id: comp_c40_a_rc_rc
        initialState: comp_23a_a_rc_rc
        SignalTransition {
            targetState: final_540_9_rc_rc
            signal: comp_c40_a_rc_rc.finished
        }
        SignalTransition {
            targetState: hardSwitchOff_finished_tv_rc_707_b
            signal: tv.hardswitchoffOccured // hardSwitchOff_tv
        }
        onEntered: {
            console.log("rc: comp_c40_a_rc_rc entered")
            //update UI
        }
        onExited: {
            console.log("rc: comp_c40_a_rc_rc exited")
        }
        State {
            id: comp_23a_a_rc_rc
            initialState: init_402_a_rc_rc
            SignalTransition {
                targetState: final_9d2_b_rc_rc
                signal: comp_23a_a_rc_rc.finished
            }
            SignalTransition {
                targetState: pending_845_a_tv_rc_7ad_9
                signal: sp.softswitchoffOccured // softSwitchOff_sp
            }
            SignalTransition {
                targetState: pending_845_a_tv_rc_7ad_9
                signal: onOffButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("softSwitchOff_rc", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("rc: comp_23a_a_rc_rc entered")
                //update UI
                onOffButton.enabled = true
            }
            onExited: {
                console.log("rc: comp_23a_a_rc_rc exited")
                onOffButton.enabled = false
            }
            State {
                id: init_402_a_rc_rc
                SignalTransition {
                    targetState: pending_045_a_tv_rc_r_b60_8
                    signal: chanMinusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("channelDown_rc", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_428_a_tv_rc_r_7f8_a
                    signal: sp.channelselectOccured // channelSelect_sp
                }
                SignalTransition {
                    targetState: pending_9bc_a_tv_rc_r_b7f_9
                    signal: sp.channelupOccured // channelUp_sp
                }
                SignalTransition {
                    targetState: pending_eec_a_tv_rc_l_d7f_b
                    signal: volPlusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("volumeUp_rc", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_9bc_a_tv_rc_r_b7f_9
                    signal: chanPlusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("channelUp_rc", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_946_a_tv_rc_l_2df_9
                    signal: muteButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("mute_rc", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_045_a_tv_rc_r_b60_8
                    signal: sp.channeldownOccured // channelDown_sp
                }
                SignalTransition {
                    targetState: pending_df8_8_tv_rc_l_fca_9
                    signal: sp.volumedownOccured // volumeDown_sp
                }
                SignalTransition {
                    targetState: pending_946_a_tv_rc_l_2df_9
                    signal: sp.muteOccured // mute_sp
                }
                SignalTransition {
                    targetState: pending_eec_a_tv_rc_l_d7f_b
                    signal: sp.volumeupOccured // volumeUp_sp
                }
                SignalTransition {
                    targetState: pending_df8_8_tv_rc_l_fca_9
                    signal: volMinusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("volumeDown_rc", "")
                        local.release()
                    }
                }
                onEntered: {
                    console.log("rc: init_402_a_rc_rc entered")
                    //update UI
                    onOffButton.enabled = true
                    muteButton.enabled = true
                    volMinusButton.enabled = true
                    chanMinusButton.enabled = true
                    volPlusButton.enabled = true
                    chanPlusButton.enabled = true
                }
                onExited: {
                    console.log("rc: init_402_a_rc_rc exited")
                    muteButton.enabled = false
                    volMinusButton.enabled = false
                    chanMinusButton.enabled = false
                    volPlusButton.enabled = false
                    chanPlusButton.enabled = false
                }
            }
            State {
                id: par_07e_8_rc
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_628_9_rc_rc
                    signal: par_07e_8_rc.finished
                }
                onEntered: {
                    console.log("rc: par_07e_8_rc entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("rc: par_07e_8_rc exited")
                }
                State {
                    id: comp_6bb_8_rc_rc
                    initialState: init_9e2_8_rc_rc_r
                    onEntered: {
                        console.log("rc: comp_6bb_8_rc_rc entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("rc: comp_6bb_8_rc_rc exited")
                    }
                    State {
                        id: init_9e2_8_rc_rc_r
                        SignalTransition {
                            targetState: pending_224_a_tv_rc_r_c14_9
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_38b_b_tv_rc_r_0b9_a
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_96b_8_tv_rc_r_a58_a
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: pending_38b_b_tv_rc_r_0b9_a
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: pending_224_a_tv_rc_r_c14_9
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: pending_96b_8_tv_rc_r_a58_a
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_rc", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("rc_r: init_9e2_8_rc_rc_r entered")
                            //update UI
                            onOffButton.enabled = true
                            volPlusButton.enabled = true
                            muteButton.enabled = true
                            volMinusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r: init_9e2_8_rc_rc_r exited")
                            volPlusButton.enabled = false
                            muteButton.enabled = false
                            volMinusButton.enabled = false
                        }
                    }
                    State {
                        id: pending_224_a_tv_rc_r_c14_9
                        SignalTransition {
                            targetState: loop_fcb_9_rc_rc_r
                            signal: tv.performvolumeupFinishedOccured // performVolumeUp_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_c14_9: pending_224_a_tv_rc_r_c14_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_c14_9: pending_224_a_tv_rc_r_c14_9 exited")
                        }
                    }
                    State {
                        id: loop_fcb_9_rc_rc_r
                        SignalTransition {
                            targetState: final_d7d_8_rc_rc_r
                            signal: loopFcb9Finished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_224_a_tv_rc_r_c14_9
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_38b_b_tv_rc_r_0b9_a
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_96b_8_tv_rc_r_a58_a
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: pending_38b_b_tv_rc_r_0b9_a
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: pending_224_a_tv_rc_r_c14_9
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: pending_96b_8_tv_rc_r_a58_a
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_rc", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("rc_r: loop_fcb_9_rc_rc_r entered")
                            //update UI
                            onOffButton.enabled = true
                            volPlusButton.enabled = true
                            muteButton.enabled = true
                            volMinusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r: loop_fcb_9_rc_rc_r exited")
                            volPlusButton.enabled = false
                            muteButton.enabled = false
                            volMinusButton.enabled = false
                        }
                    }
                    FinalState {
                        id: final_d7d_8_rc_rc_r
                        onEntered: {
                            console.log("rc_r: final_d7d_8_rc_rc_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r: final_d7d_8_rc_rc_r exited")
                        }
                    }
                    State {
                        id: pending_38b_b_tv_rc_r_0b9_a
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_rc_r_0b9_a
                            signal: tv.performmuteFinishedOccured // performMute_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_0b9_a: pending_38b_b_tv_rc_r_0b9_a entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_0b9_a: pending_38b_b_tv_rc_r_0b9_a exited")
                        }
                    }
                    State {
                        id: performMute_finished_finished_tv_rc_r_0b9_a
                        SignalTransition {
                            targetState: pending_570_a_tv_rc_r_8ba_a
                            signal: sp.unmuteOccured // unmute_sp
                        }
                        SignalTransition {
                            targetState: pending_570_a_tv_rc_r_8ba_a
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("unmute_rc", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("rc_r_0b9_a: performMute_finished_finished_tv_rc_r_0b9_a entered")
                            //update UI
                            onOffButton.enabled = true
                            muteButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_0b9_a: performMute_finished_finished_tv_rc_r_0b9_a exited")
                            muteButton.enabled = false
                        }
                    }
                    State {
                        id: pending_570_a_tv_rc_r_8ba_a
                        SignalTransition {
                            targetState: loop_fcb_9_rc_rc_r
                            signal: tv.performunmuteFinishedOccured // performUnmute_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_8ba_a: pending_570_a_tv_rc_r_8ba_a entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_8ba_a: pending_570_a_tv_rc_r_8ba_a exited")
                        }
                    }
                    State {
                        id: pending_96b_8_tv_rc_r_a58_a
                        SignalTransition {
                            targetState: loop_fcb_9_rc_rc_r
                            signal: tv.performvolumedownFinishedOccured // performVolumeDown_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_a58_a: pending_96b_8_tv_rc_r_a58_a entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_a58_a: pending_96b_8_tv_rc_r_a58_a exited")
                        }
                    }
                }
                State {
                    id: comp_64c_b_rc_rc
                    initialState: pending_9bc_a_tv_rc_r_b7f_9
                    onEntered: {
                        console.log("rc: comp_64c_b_rc_rc entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("rc: comp_64c_b_rc_rc exited")
                    }
                    State {
                        id: pending_9bc_a_tv_rc_r_b7f_9
                        SignalTransition {
                            targetState: loop_c0c_a_rc_rc_r
                            signal: tv.performchannelupFinishedOccured // performChannelUp_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_b7f_9: pending_9bc_a_tv_rc_r_b7f_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_b7f_9: pending_9bc_a_tv_rc_r_b7f_9 exited")
                        }
                    }
                    State {
                        id: loop_c0c_a_rc_rc_r
                        SignalTransition {
                            targetState: pending_045_a_tv_rc_r_b60_8
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_428_a_tv_rc_r_7f8_a
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: final_c3e_9_rc_rc_r
                            signal: loopC0cAFinished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_9bc_a_tv_rc_r_b7f_9
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: pending_9bc_a_tv_rc_r_b7f_9
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_045_a_tv_rc_r_b60_8
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        onEntered: {
                            console.log("rc_r: loop_c0c_a_rc_rc_r entered")
                            //update UI
                            onOffButton.enabled = true
                            chanMinusButton.enabled = true
                            chanPlusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r: loop_c0c_a_rc_rc_r exited")
                            chanMinusButton.enabled = false
                            chanPlusButton.enabled = false
                        }
                    }
                    State {
                        id: pending_045_a_tv_rc_r_b60_8
                        SignalTransition {
                            targetState: loop_c0c_a_rc_rc_r
                            signal: tv.performchanneldownFinishedOccured // performChannelDown_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_b60_8: pending_045_a_tv_rc_r_b60_8 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_b60_8: pending_045_a_tv_rc_r_b60_8 exited")
                        }
                    }
                    State {
                        id: pending_428_a_tv_rc_r_7f8_a
                        SignalTransition {
                            targetState: loop_c0c_a_rc_rc_r
                            signal: tv.gotochannelFinishedOccured // gotoChannel_finished_tv
                        }
                        onEntered: {
                            console.log("rc_r_7f8_a: pending_428_a_tv_rc_r_7f8_a entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r_7f8_a: pending_428_a_tv_rc_r_7f8_a exited")
                        }
                    }
                    FinalState {
                        id: final_c3e_9_rc_rc_r
                        onEntered: {
                            console.log("rc_r: final_c3e_9_rc_rc_r entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_r: final_c3e_9_rc_rc_r exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_628_9_rc_rc
                onEntered: {
                    console.log("rc: final_628_9_rc_rc entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("rc: final_628_9_rc_rc exited")
                }
            }
            State {
                id: par_ce1_9_rc
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_628_9_rc_rc
                    signal: par_ce1_9_rc.finished
                }
                onEntered: {
                    console.log("rc: par_ce1_9_rc entered")
                    //update UI
                    onOffButton.enabled = true
                }
                onExited: {
                    console.log("rc: par_ce1_9_rc exited")
                }
                State {
                    id: comp_bd2_a_rc_rc
                    initialState: performMute_finished_finished_tv_rc_l_2df_9
                    onEntered: {
                        console.log("rc: comp_bd2_a_rc_rc entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("rc: comp_bd2_a_rc_rc exited")
                    }
                    State {
                        id: performMute_finished_finished_tv_rc_l_2df_9
                        SignalTransition {
                            targetState: pending_d19_8_tv_rc_l_438_a
                            signal: sp.unmuteOccured // unmute_sp
                        }
                        SignalTransition {
                            targetState: pending_d19_8_tv_rc_l_438_a
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("unmute_rc", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("rc_l_2df_9: performMute_finished_finished_tv_rc_l_2df_9 entered")
                            //update UI
                            onOffButton.enabled = true
                            muteButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_2df_9: performMute_finished_finished_tv_rc_l_2df_9 exited")
                            muteButton.enabled = false
                        }
                    }
                    State {
                        id: pending_d19_8_tv_rc_l_438_a
                        SignalTransition {
                            targetState: loop_d4d_a_rc_rc_l
                            signal: tv.performunmuteFinishedOccured // performUnmute_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_438_a: pending_d19_8_tv_rc_l_438_a entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_438_a: pending_d19_8_tv_rc_l_438_a exited")
                        }
                    }
                    State {
                        id: loop_d4d_a_rc_rc_l
                        SignalTransition {
                            targetState: pending_eec_a_tv_rc_l_d7f_b
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_946_a_tv_rc_l_2df_9
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_df8_8_tv_rc_l_fca_9
                            signal: sp.volumedownOccured // volumeDown_sp
                        }
                        SignalTransition {
                            targetState: pending_946_a_tv_rc_l_2df_9
                            signal: sp.muteOccured // mute_sp
                        }
                        SignalTransition {
                            targetState: pending_eec_a_tv_rc_l_d7f_b
                            signal: sp.volumeupOccured // volumeUp_sp
                        }
                        SignalTransition {
                            targetState: pending_df8_8_tv_rc_l_fca_9
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: final_c5a_9_rc_rc_l
                            signal: loopD4dAFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("rc_l: loop_d4d_a_rc_rc_l entered")
                            //update UI
                            onOffButton.enabled = true
                            volPlusButton.enabled = true
                            muteButton.enabled = true
                            volMinusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l: loop_d4d_a_rc_rc_l exited")
                            volPlusButton.enabled = false
                            muteButton.enabled = false
                            volMinusButton.enabled = false
                        }
                    }
                    State {
                        id: pending_eec_a_tv_rc_l_d7f_b
                        SignalTransition {
                            targetState: loop_d4d_a_rc_rc_l
                            signal: tv.performvolumeupFinishedOccured // performVolumeUp_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_d7f_b: pending_eec_a_tv_rc_l_d7f_b entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_d7f_b: pending_eec_a_tv_rc_l_d7f_b exited")
                        }
                    }
                    State {
                        id: pending_946_a_tv_rc_l_2df_9
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_rc_l_2df_9
                            signal: tv.performmuteFinishedOccured // performMute_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_2df_9: pending_946_a_tv_rc_l_2df_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_2df_9: pending_946_a_tv_rc_l_2df_9 exited")
                        }
                    }
                    State {
                        id: pending_df8_8_tv_rc_l_fca_9
                        SignalTransition {
                            targetState: loop_d4d_a_rc_rc_l
                            signal: tv.performvolumedownFinishedOccured // performVolumeDown_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_fca_9: pending_df8_8_tv_rc_l_fca_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_fca_9: pending_df8_8_tv_rc_l_fca_9 exited")
                        }
                    }
                    FinalState {
                        id: final_c5a_9_rc_rc_l
                        onEntered: {
                            console.log("rc_l: final_c5a_9_rc_rc_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l: final_c5a_9_rc_rc_l exited")
                        }
                    }
                }
                State {
                    id: comp_6fa_b_rc_rc
                    initialState: init_b4b_b_rc_rc_l
                    onEntered: {
                        console.log("rc: comp_6fa_b_rc_rc entered")
                        //update UI
                        onOffButton.enabled = true
                    }
                    onExited: {
                        console.log("rc: comp_6fa_b_rc_rc exited")
                    }
                    State {
                        id: init_b4b_b_rc_rc_l
                        SignalTransition {
                            targetState: pending_5e8_8_tv_rc_l_4a1_9
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_fee_a_tv_rc_l_d8f_9
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: pending_9f7_8_tv_rc_l_9fc_9
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: pending_9f7_8_tv_rc_l_9fc_9
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5e8_8_tv_rc_l_4a1_9
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        onEntered: {
                            console.log("rc_l: init_b4b_b_rc_rc_l entered")
                            //update UI
                            onOffButton.enabled = true
                            chanMinusButton.enabled = true
                            chanPlusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l: init_b4b_b_rc_rc_l exited")
                            chanMinusButton.enabled = false
                            chanPlusButton.enabled = false
                        }
                    }
                    State {
                        id: pending_5e8_8_tv_rc_l_4a1_9
                        SignalTransition {
                            targetState: loop_5c3_a_rc_rc_l
                            signal: tv.performchanneldownFinishedOccured // performChannelDown_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_4a1_9: pending_5e8_8_tv_rc_l_4a1_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_4a1_9: pending_5e8_8_tv_rc_l_4a1_9 exited")
                        }
                    }
                    State {
                        id: loop_5c3_a_rc_rc_l
                        SignalTransition {
                            targetState: pending_5e8_8_tv_rc_l_4a1_9
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_fee_a_tv_rc_l_d8f_9
                            signal: sp.channelselectOccured // channelSelect_sp
                        }
                        SignalTransition {
                            targetState: pending_9f7_8_tv_rc_l_9fc_9
                            signal: sp.channelupOccured // channelUp_sp
                        }
                        SignalTransition {
                            targetState: final_d1a_a_rc_rc_l
                            signal: loop5c3AFinished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_9f7_8_tv_rc_l_9fc_9
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_rc", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5e8_8_tv_rc_l_4a1_9
                            signal: sp.channeldownOccured // channelDown_sp
                        }
                        onEntered: {
                            console.log("rc_l: loop_5c3_a_rc_rc_l entered")
                            //update UI
                            onOffButton.enabled = true
                            chanMinusButton.enabled = true
                            chanPlusButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l: loop_5c3_a_rc_rc_l exited")
                            chanMinusButton.enabled = false
                            chanPlusButton.enabled = false
                        }
                    }
                    State {
                        id: pending_fee_a_tv_rc_l_d8f_9
                        SignalTransition {
                            targetState: loop_5c3_a_rc_rc_l
                            signal: tv.gotochannelFinishedOccured // gotoChannel_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_d8f_9: pending_fee_a_tv_rc_l_d8f_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_d8f_9: pending_fee_a_tv_rc_l_d8f_9 exited")
                        }
                    }
                    State {
                        id: pending_9f7_8_tv_rc_l_9fc_9
                        SignalTransition {
                            targetState: loop_5c3_a_rc_rc_l
                            signal: tv.performchannelupFinishedOccured // performChannelUp_finished_tv
                        }
                        onEntered: {
                            console.log("rc_l_9fc_9: pending_9f7_8_tv_rc_l_9fc_9 entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l_9fc_9: pending_9f7_8_tv_rc_l_9fc_9 exited")
                        }
                    }
                    FinalState {
                        id: final_d1a_a_rc_rc_l
                        onEntered: {
                            console.log("rc_l: final_d1a_a_rc_rc_l entered")
                            //update UI
                            onOffButton.enabled = true
                        }
                        onExited: {
                            console.log("rc_l: final_d1a_a_rc_rc_l exited")
                        }
                    }
                }
            }
        }
        FinalState {
            id: final_9d2_b_rc_rc
            onEntered: {
                console.log("rc: final_9d2_b_rc_rc entered")
                //update UI
            }
            onExited: {
                console.log("rc: final_9d2_b_rc_rc exited")
            }
        }
        State {
            id: pending_845_a_tv_rc_7ad_9
            SignalTransition {
                targetState: standBy_finished_finished_tv_rc_7ad_9
                signal: tv.standbyFinishedOccured // standBy_finished_tv
            }
            onEntered: {
                console.log("rc_7ad_9: pending_845_a_tv_rc_7ad_9 entered")
                //update UI
            }
            onExited: {
                console.log("rc_7ad_9: pending_845_a_tv_rc_7ad_9 exited")
            }
        }
        State {
            id: standBy_finished_finished_tv_rc_7ad_9
            SignalTransition {
                targetState: pending_caf_9_tv_rc_eab_8
                signal: sp.softswitchonOccured // softSwitchOn_sp
            }
            SignalTransition {
                targetState: pending_caf_9_tv_rc_eab_8
                signal: onOffButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("softSwitchOn_rc", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("rc_7ad_9: standBy_finished_finished_tv_rc_7ad_9 entered")
                //update UI
                onOffButton.enabled = true
            }
            onExited: {
                console.log("rc_7ad_9: standBy_finished_finished_tv_rc_7ad_9 exited")
                onOffButton.enabled = false
            }
        }
        State {
            id: pending_caf_9_tv_rc_eab_8
            SignalTransition {
                targetState: comp_23a_a_rc_rc
                signal: tv.returnfromstandbyFinishedOccured // returnFromStandBy_finished_tv
            }
            onEntered: {
                console.log("rc_eab_8: pending_caf_9_tv_rc_eab_8 entered")
                //update UI
            }
            onExited: {
                console.log("rc_eab_8: pending_caf_9_tv_rc_eab_8 exited")
            }
        }
    }
    FinalState {
        id: final_540_9_rc_rc
        onEntered: {
            console.log("rc: final_540_9_rc_rc entered")
            //update UI
        }
        onExited: {
            console.log("rc: final_540_9_rc_rc exited")
        }
    }
    State {
        id: hardSwitchOff_finished_tv_rc_707_b
        SignalTransition {
            targetState: comp_c40_a_rc_rc
            signal: tv.hardswitchonOccured // hardSwitchOn_tv
        }
        onEntered: {
            console.log("rc_707_b: hardSwitchOff_finished_tv_rc_707_b entered")
            //update UI
        }
        onExited: {
            console.log("rc_707_b: hardSwitchOff_finished_tv_rc_707_b exited")
        }
    }
    function dummy_loop_fcb_9_finished_callback(){
        loopFcb9Finished()
    }
    function dummy_loop_c0c_a_finished_callback(){
        loopC0cAFinished()
    }
    function dummy_loop_d4d_a_finished_callback(){
        loopD4dAFinished()
    }
    function dummy_loop_5c3_a_finished_callback(){
        loop5c3AFinished()
    }
    signal loopFcb9Finished
    signal loopC0cAFinished
    signal loopD4dAFinished
    signal loop5c3AFinished
}
