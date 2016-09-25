import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_sp
    initialState: comp_a4c_8_sp_sp
    //activate state machine
    running: true
    State {
        id: comp_a4c_8_sp_sp
        initialState: comp_aba_a_sp_sp
        SignalTransition {
            targetState: final_ac8_b_sp_sp
            signal: comp_a4c_8_sp_sp.finished
        }
        SignalTransition {
            targetState: hardSwitchOff_finished_tv_sp_632_8
            signal: tv.hardswitchoffOccured // hardSwitchOff_tv
        }
        onEntered: {
            console.log("sp: comp_a4c_8_sp_sp entered")
            //update UI
        }
        onExited: {
            console.log("sp: comp_a4c_8_sp_sp exited")
        }
        State {
            id: comp_aba_a_sp_sp
            initialState: init_5d4_9_sp_sp
            SignalTransition {
                targetState: final_eca_b_sp_sp
                signal: comp_aba_a_sp_sp.finished
            }
            SignalTransition {
                targetState: pending_b5d_9_tv_sp_840_a
                signal: onOffButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("softSwitchOff_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: pending_b5d_9_tv_sp_840_a
                signal: rc.softswitchoffOccured // softSwitchOff_rc
            }
            onEntered: {
                console.log("sp: comp_aba_a_sp_sp entered")
                //update UI
                onOffButton.visible = true
            }
            onExited: {
                console.log("sp: comp_aba_a_sp_sp exited")
                onOffButton.visible = false
            }
            State {
                id: init_5d4_9_sp_sp
                SignalTransition {
                    targetState: pending_251_8_tv_sp_r_d32_b
                    signal: rc.channeldownOccured // channelDown_rc
                }
                SignalTransition {
                    targetState: pending_e4d_a_tv_sp_r_f9a_8
                    signal: channelAcceptButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        var data = spmodel.getChannel()
                        local.broadcastTransition("channelSelect_sp", data)
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_d37_9_tv_sp_r_1a0_b
                    signal: chanPlusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("channelUp_sp", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_913_8_tv_sp_l_216_a
                    signal: rc.volumeupOccured // volumeUp_rc
                }
                SignalTransition {
                    targetState: pending_d37_9_tv_sp_r_1a0_b
                    signal: rc.channelupOccured // channelUp_rc
                }
                SignalTransition {
                    targetState: pending_a44_8_tv_sp_l_e84_a
                    signal: rc.muteOccured // mute_rc
                }
                SignalTransition {
                    targetState: pending_251_8_tv_sp_r_d32_b
                    signal: chanMinusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("channelDown_sp", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_78b_a_tv_sp_l_5af_9
                    signal: volMinusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("volumeDown_sp", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_a44_8_tv_sp_l_e84_a
                    signal: muteButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("mute_sp", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_913_8_tv_sp_l_216_a
                    signal: volPlusButton.clicked
                    guard: local.hasLock()
                    onTriggered: {
                        local.broadcastTransition("volumeUp_sp", "")
                        local.release()
                    }
                }
                SignalTransition {
                    targetState: pending_78b_a_tv_sp_l_5af_9
                    signal: rc.volumedownOccured // volumeDown_rc
                }
                onEntered: {
                    console.log("sp: init_5d4_9_sp_sp entered")
                    //update UI
                    onOffButton.visible = true
                    muteButton.visible = true
                    channelField.visible = true
                    channelAcceptButton.visible = true
                    volMinusButton.visible = true
                    chanMinusButton.visible = true
                    channelLabel.visible = true
                    volPlusButton.visible = true
                    chanPlusButton.visible = true
                }
                onExited: {
                    console.log("sp: init_5d4_9_sp_sp exited")
                    muteButton.visible = false
                    channelField.visible = false
                    channelAcceptButton.visible = false
                    volMinusButton.visible = false
                    chanMinusButton.visible = false
                    channelLabel.visible = false
                    volPlusButton.visible = false
                    chanPlusButton.visible = false
                }
            }
            State {
                id: par_e9a_b_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_28c_9_sp_sp
                    signal: par_e9a_b_sp.finished
                }
                onEntered: {
                    console.log("sp: par_e9a_b_sp entered")
                    //update UI
                    onOffButton.visible = true
                }
                onExited: {
                    console.log("sp: par_e9a_b_sp exited")
                }
                State {
                    id: comp_6c7_8_sp_sp
                    initialState: init_b8c_8_sp_sp_r
                    onEntered: {
                        console.log("sp: comp_6c7_8_sp_sp entered")
                        //update UI
                        onOffButton.visible = true
                    }
                    onExited: {
                        console.log("sp: comp_6c7_8_sp_sp exited")
                    }
                    State {
                        id: init_b8c_8_sp_sp_r
                        SignalTransition {
                            targetState: pending_b61_a_tv_sp_r_3b8_a
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: pending_4df_b_tv_sp_r_58a_b
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: pending_5b6_a_tv_sp_r_a59_9
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_4df_b_tv_sp_r_58a_b
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_b61_a_tv_sp_r_3b8_a
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5b6_a_tv_sp_r_a59_9
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("sp_r: init_b8c_8_sp_sp_r entered")
                            //update UI
                            onOffButton.visible = true
                            volMinusButton.visible = true
                            muteButton.visible = true
                            volPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r: init_b8c_8_sp_sp_r exited")
                            volMinusButton.visible = false
                            muteButton.visible = false
                            volPlusButton.visible = false
                        }
                    }
                    State {
                        id: pending_b61_a_tv_sp_r_3b8_a
                        SignalTransition {
                            targetState: loop_4ca_9_sp_sp_r
                            signal: tv.performvolumeupFinishedOccured // performVolumeUp_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_3b8_a: pending_b61_a_tv_sp_r_3b8_a entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_3b8_a: pending_b61_a_tv_sp_r_3b8_a exited")
                        }
                    }
                    State {
                        id: loop_4ca_9_sp_sp_r
                        SignalTransition {
                            targetState: final_3a5_8_sp_sp_r
                            signal: loop4ca9Finished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_b61_a_tv_sp_r_3b8_a
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: pending_4df_b_tv_sp_r_58a_b
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: pending_5b6_a_tv_sp_r_a59_9
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_4df_b_tv_sp_r_58a_b
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_b61_a_tv_sp_r_3b8_a
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5b6_a_tv_sp_r_a59_9
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("sp_r: loop_4ca_9_sp_sp_r entered")
                            //update UI
                            onOffButton.visible = true
                            volMinusButton.visible = true
                            muteButton.visible = true
                            volPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r: loop_4ca_9_sp_sp_r exited")
                            volMinusButton.visible = false
                            muteButton.visible = false
                            volPlusButton.visible = false
                        }
                    }
                    FinalState {
                        id: final_3a5_8_sp_sp_r
                        onEntered: {
                            console.log("sp_r: final_3a5_8_sp_sp_r entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r: final_3a5_8_sp_sp_r exited")
                        }
                    }
                    State {
                        id: pending_4df_b_tv_sp_r_58a_b
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_sp_r_58a_b
                            signal: tv.performmuteFinishedOccured // performMute_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_58a_b: pending_4df_b_tv_sp_r_58a_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_58a_b: pending_4df_b_tv_sp_r_58a_b exited")
                        }
                    }
                    State {
                        id: performMute_finished_finished_tv_sp_r_58a_b
                        SignalTransition {
                            targetState: pending_308_b_tv_sp_r_fc5_9
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("unmute_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_308_b_tv_sp_r_fc5_9
                            signal: rc.unmuteOccured // unmute_rc
                        }
                        onEntered: {
                            console.log("sp_r_58a_b: performMute_finished_finished_tv_sp_r_58a_b entered")
                            //update UI
                            onOffButton.visible = true
                            muteButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_58a_b: performMute_finished_finished_tv_sp_r_58a_b exited")
                            muteButton.visible = false
                        }
                    }
                    State {
                        id: pending_308_b_tv_sp_r_fc5_9
                        SignalTransition {
                            targetState: loop_4ca_9_sp_sp_r
                            signal: tv.performunmuteFinishedOccured // performUnmute_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_fc5_9: pending_308_b_tv_sp_r_fc5_9 entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_fc5_9: pending_308_b_tv_sp_r_fc5_9 exited")
                        }
                    }
                    State {
                        id: pending_5b6_a_tv_sp_r_a59_9
                        SignalTransition {
                            targetState: loop_4ca_9_sp_sp_r
                            signal: tv.performvolumedownFinishedOccured // performVolumeDown_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_a59_9: pending_5b6_a_tv_sp_r_a59_9 entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_a59_9: pending_5b6_a_tv_sp_r_a59_9 exited")
                        }
                    }
                }
                State {
                    id: comp_57e_a_sp_sp
                    initialState: pending_d37_9_tv_sp_r_1a0_b
                    onEntered: {
                        console.log("sp: comp_57e_a_sp_sp entered")
                        //update UI
                        onOffButton.visible = true
                    }
                    onExited: {
                        console.log("sp: comp_57e_a_sp_sp exited")
                    }
                    State {
                        id: pending_d37_9_tv_sp_r_1a0_b
                        SignalTransition {
                            targetState: loop_5b0_a_sp_sp_r
                            signal: tv.performchannelupFinishedOccured // performChannelUp_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_1a0_b: pending_d37_9_tv_sp_r_1a0_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_1a0_b: pending_d37_9_tv_sp_r_1a0_b exited")
                        }
                    }
                    State {
                        id: loop_5b0_a_sp_sp_r
                        SignalTransition {
                            targetState: pending_251_8_tv_sp_r_d32_b
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: pending_e4d_a_tv_sp_r_f9a_8
                            signal: channelAcceptButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                var data = spmodel.getChannel()
                                local.broadcastTransition("channelSelect_sp", data)
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_d37_9_tv_sp_r_1a0_b
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_d37_9_tv_sp_r_1a0_b
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: pending_251_8_tv_sp_r_d32_b
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: final_557_a_sp_sp_r
                            signal: loop5b0AFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_r: loop_5b0_a_sp_sp_r entered")
                            //update UI
                            onOffButton.visible = true
                            channelField.visible = true
                            channelAcceptButton.visible = true
                            chanMinusButton.visible = true
                            channelLabel.visible = true
                            chanPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r: loop_5b0_a_sp_sp_r exited")
                            channelField.visible = false
                            channelAcceptButton.visible = false
                            chanMinusButton.visible = false
                            channelLabel.visible = false
                            chanPlusButton.visible = false
                        }
                    }
                    State {
                        id: pending_251_8_tv_sp_r_d32_b
                        SignalTransition {
                            targetState: loop_5b0_a_sp_sp_r
                            signal: tv.performchanneldownFinishedOccured // performChannelDown_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_d32_b: pending_251_8_tv_sp_r_d32_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_d32_b: pending_251_8_tv_sp_r_d32_b exited")
                        }
                    }
                    State {
                        id: pending_e4d_a_tv_sp_r_f9a_8
                        SignalTransition {
                            targetState: loop_5b0_a_sp_sp_r
                            signal: tv.gotochannelFinishedOccured // gotoChannel_finished_tv
                        }
                        onEntered: {
                            console.log("sp_r_f9a_8: pending_e4d_a_tv_sp_r_f9a_8 entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r_f9a_8: pending_e4d_a_tv_sp_r_f9a_8 exited")
                        }
                    }
                    FinalState {
                        id: final_557_a_sp_sp_r
                        onEntered: {
                            console.log("sp_r: final_557_a_sp_sp_r entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_r: final_557_a_sp_sp_r exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_28c_9_sp_sp
                onEntered: {
                    console.log("sp: final_28c_9_sp_sp entered")
                    //update UI
                    onOffButton.visible = true
                }
                onExited: {
                    console.log("sp: final_28c_9_sp_sp exited")
                }
            }
            State {
                id: par_137_b_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_28c_9_sp_sp
                    signal: par_137_b_sp.finished
                }
                onEntered: {
                    console.log("sp: par_137_b_sp entered")
                    //update UI
                    onOffButton.visible = true
                }
                onExited: {
                    console.log("sp: par_137_b_sp exited")
                }
                State {
                    id: comp_9e2_8_sp_sp
                    initialState: performMute_finished_finished_tv_sp_l_e84_a
                    onEntered: {
                        console.log("sp: comp_9e2_8_sp_sp entered")
                        //update UI
                        onOffButton.visible = true
                    }
                    onExited: {
                        console.log("sp: comp_9e2_8_sp_sp exited")
                    }
                    State {
                        id: performMute_finished_finished_tv_sp_l_e84_a
                        SignalTransition {
                            targetState: pending_eed_8_tv_sp_l_241_9
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("unmute_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_eed_8_tv_sp_l_241_9
                            signal: rc.unmuteOccured // unmute_rc
                        }
                        onEntered: {
                            console.log("sp_l_e84_a: performMute_finished_finished_tv_sp_l_e84_a entered")
                            //update UI
                            onOffButton.visible = true
                            muteButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_e84_a: performMute_finished_finished_tv_sp_l_e84_a exited")
                            muteButton.visible = false
                        }
                    }
                    State {
                        id: pending_eed_8_tv_sp_l_241_9
                        SignalTransition {
                            targetState: loop_a4e_a_sp_sp_l
                            signal: tv.performunmuteFinishedOccured // performUnmute_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_241_9: pending_eed_8_tv_sp_l_241_9 entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_241_9: pending_eed_8_tv_sp_l_241_9 exited")
                        }
                    }
                    State {
                        id: loop_a4e_a_sp_sp_l
                        SignalTransition {
                            targetState: pending_913_8_tv_sp_l_216_a
                            signal: rc.volumeupOccured // volumeUp_rc
                        }
                        SignalTransition {
                            targetState: final_4b5_9_sp_sp_l
                            signal: loopA4eAFinished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_a44_8_tv_sp_l_e84_a
                            signal: rc.muteOccured // mute_rc
                        }
                        SignalTransition {
                            targetState: pending_78b_a_tv_sp_l_5af_9
                            signal: volMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeDown_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_a44_8_tv_sp_l_e84_a
                            signal: muteButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("mute_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_913_8_tv_sp_l_216_a
                            signal: volPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("volumeUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_78b_a_tv_sp_l_5af_9
                            signal: rc.volumedownOccured // volumeDown_rc
                        }
                        onEntered: {
                            console.log("sp_l: loop_a4e_a_sp_sp_l entered")
                            //update UI
                            onOffButton.visible = true
                            volMinusButton.visible = true
                            muteButton.visible = true
                            volPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l: loop_a4e_a_sp_sp_l exited")
                            volMinusButton.visible = false
                            muteButton.visible = false
                            volPlusButton.visible = false
                        }
                    }
                    State {
                        id: pending_913_8_tv_sp_l_216_a
                        SignalTransition {
                            targetState: loop_a4e_a_sp_sp_l
                            signal: tv.performvolumeupFinishedOccured // performVolumeUp_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_216_a: pending_913_8_tv_sp_l_216_a entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_216_a: pending_913_8_tv_sp_l_216_a exited")
                        }
                    }
                    FinalState {
                        id: final_4b5_9_sp_sp_l
                        onEntered: {
                            console.log("sp_l: final_4b5_9_sp_sp_l entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l: final_4b5_9_sp_sp_l exited")
                        }
                    }
                    State {
                        id: pending_a44_8_tv_sp_l_e84_a
                        SignalTransition {
                            targetState: performMute_finished_finished_tv_sp_l_e84_a
                            signal: tv.performmuteFinishedOccured // performMute_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_e84_a: pending_a44_8_tv_sp_l_e84_a entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_e84_a: pending_a44_8_tv_sp_l_e84_a exited")
                        }
                    }
                    State {
                        id: pending_78b_a_tv_sp_l_5af_9
                        SignalTransition {
                            targetState: loop_a4e_a_sp_sp_l
                            signal: tv.performvolumedownFinishedOccured // performVolumeDown_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_5af_9: pending_78b_a_tv_sp_l_5af_9 entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_5af_9: pending_78b_a_tv_sp_l_5af_9 exited")
                        }
                    }
                }
                State {
                    id: comp_539_9_sp_sp
                    initialState: init_37c_a_sp_sp_l
                    onEntered: {
                        console.log("sp: comp_539_9_sp_sp entered")
                        //update UI
                        onOffButton.visible = true
                    }
                    onExited: {
                        console.log("sp: comp_539_9_sp_sp exited")
                    }
                    State {
                        id: init_37c_a_sp_sp_l
                        SignalTransition {
                            targetState: pending_378_9_tv_sp_l_a01_b
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: pending_2a8_9_tv_sp_l_08d_b
                            signal: channelAcceptButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                var data = spmodel.getChannel()
                                local.broadcastTransition("channelSelect_sp", data)
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5c0_8_tv_sp_l_f8d_b
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5c0_8_tv_sp_l_f8d_b
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: pending_378_9_tv_sp_l_a01_b
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_sp", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("sp_l: init_37c_a_sp_sp_l entered")
                            //update UI
                            onOffButton.visible = true
                            channelField.visible = true
                            channelAcceptButton.visible = true
                            chanMinusButton.visible = true
                            channelLabel.visible = true
                            chanPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l: init_37c_a_sp_sp_l exited")
                            channelField.visible = false
                            channelAcceptButton.visible = false
                            chanMinusButton.visible = false
                            channelLabel.visible = false
                            chanPlusButton.visible = false
                        }
                    }
                    State {
                        id: pending_378_9_tv_sp_l_a01_b
                        SignalTransition {
                            targetState: loop_4b2_b_sp_sp_l
                            signal: tv.performchanneldownFinishedOccured // performChannelDown_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_a01_b: pending_378_9_tv_sp_l_a01_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_a01_b: pending_378_9_tv_sp_l_a01_b exited")
                        }
                    }
                    State {
                        id: loop_4b2_b_sp_sp_l
                        SignalTransition {
                            targetState: final_38e_9_sp_sp_l
                            signal: loop4b2BFinished
                            onTriggered: {
                            }
                        }
                        SignalTransition {
                            targetState: pending_378_9_tv_sp_l_a01_b
                            signal: rc.channeldownOccured // channelDown_rc
                        }
                        SignalTransition {
                            targetState: pending_2a8_9_tv_sp_l_08d_b
                            signal: channelAcceptButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                var data = spmodel.getChannel()
                                local.broadcastTransition("channelSelect_sp", data)
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5c0_8_tv_sp_l_f8d_b
                            signal: chanPlusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelUp_sp", "")
                                local.release()
                            }
                        }
                        SignalTransition {
                            targetState: pending_5c0_8_tv_sp_l_f8d_b
                            signal: rc.channelupOccured // channelUp_rc
                        }
                        SignalTransition {
                            targetState: pending_378_9_tv_sp_l_a01_b
                            signal: chanMinusButton.clicked
                            guard: local.hasLock()
                            onTriggered: {
                                local.broadcastTransition("channelDown_sp", "")
                                local.release()
                            }
                        }
                        onEntered: {
                            console.log("sp_l: loop_4b2_b_sp_sp_l entered")
                            //update UI
                            onOffButton.visible = true
                            channelField.visible = true
                            channelAcceptButton.visible = true
                            chanMinusButton.visible = true
                            channelLabel.visible = true
                            chanPlusButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l: loop_4b2_b_sp_sp_l exited")
                            channelField.visible = false
                            channelAcceptButton.visible = false
                            chanMinusButton.visible = false
                            channelLabel.visible = false
                            chanPlusButton.visible = false
                        }
                    }
                    FinalState {
                        id: final_38e_9_sp_sp_l
                        onEntered: {
                            console.log("sp_l: final_38e_9_sp_sp_l entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l: final_38e_9_sp_sp_l exited")
                        }
                    }
                    State {
                        id: pending_2a8_9_tv_sp_l_08d_b
                        SignalTransition {
                            targetState: loop_4b2_b_sp_sp_l
                            signal: tv.gotochannelFinishedOccured // gotoChannel_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_08d_b: pending_2a8_9_tv_sp_l_08d_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_08d_b: pending_2a8_9_tv_sp_l_08d_b exited")
                        }
                    }
                    State {
                        id: pending_5c0_8_tv_sp_l_f8d_b
                        SignalTransition {
                            targetState: loop_4b2_b_sp_sp_l
                            signal: tv.performchannelupFinishedOccured // performChannelUp_finished_tv
                        }
                        onEntered: {
                            console.log("sp_l_f8d_b: pending_5c0_8_tv_sp_l_f8d_b entered")
                            //update UI
                            onOffButton.visible = true
                        }
                        onExited: {
                            console.log("sp_l_f8d_b: pending_5c0_8_tv_sp_l_f8d_b exited")
                        }
                    }
                }
            }
        }
        FinalState {
            id: final_eca_b_sp_sp
            onEntered: {
                console.log("sp: final_eca_b_sp_sp entered")
                //update UI
            }
            onExited: {
                console.log("sp: final_eca_b_sp_sp exited")
            }
        }
        State {
            id: pending_b5d_9_tv_sp_840_a
            SignalTransition {
                targetState: standBy_finished_finished_tv_sp_840_a
                signal: tv.standbyFinishedOccured // standBy_finished_tv
            }
            onEntered: {
                console.log("sp_840_a: pending_b5d_9_tv_sp_840_a entered")
                //update UI
            }
            onExited: {
                console.log("sp_840_a: pending_b5d_9_tv_sp_840_a exited")
            }
        }
        State {
            id: standBy_finished_finished_tv_sp_840_a
            SignalTransition {
                targetState: pending_738_8_tv_sp_287_8
                signal: onOffButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("softSwitchOn_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: pending_738_8_tv_sp_287_8
                signal: rc.softswitchonOccured // softSwitchOn_rc
            }
            onEntered: {
                console.log("sp_840_a: standBy_finished_finished_tv_sp_840_a entered")
                //update UI
                onOffButton.visible = true
            }
            onExited: {
                console.log("sp_840_a: standBy_finished_finished_tv_sp_840_a exited")
                onOffButton.visible = false
            }
        }
        State {
            id: pending_738_8_tv_sp_287_8
            SignalTransition {
                targetState: comp_aba_a_sp_sp
                signal: tv.returnfromstandbyFinishedOccured // returnFromStandBy_finished_tv
            }
            onEntered: {
                console.log("sp_287_8: pending_738_8_tv_sp_287_8 entered")
                //update UI
            }
            onExited: {
                console.log("sp_287_8: pending_738_8_tv_sp_287_8 exited")
            }
        }
    }
    FinalState {
        id: final_ac8_b_sp_sp
        onEntered: {
            console.log("sp: final_ac8_b_sp_sp entered")
            //update UI
        }
        onExited: {
            console.log("sp: final_ac8_b_sp_sp exited")
        }
    }
    State {
        id: hardSwitchOff_finished_tv_sp_632_8
        SignalTransition {
            targetState: comp_a4c_8_sp_sp
            signal: tv.hardswitchonOccured // hardSwitchOn_tv
        }
        onEntered: {
            console.log("sp_632_8: hardSwitchOff_finished_tv_sp_632_8 entered")
            //update UI
        }
        onExited: {
            console.log("sp_632_8: hardSwitchOff_finished_tv_sp_632_8 exited")
        }
    }
    function dummy_loop_4ca_9_finished_callback(){
        loop4ca9Finished()
    }
    function dummy_loop_5b0_a_finished_callback(){
        loop5b0AFinished()
    }
    function dummy_loop_a4e_a_finished_callback(){
        loopA4eAFinished()
    }
    function dummy_loop_4b2_b_finished_callback(){
        loop4b2BFinished()
    }
    signal loop4ca9Finished
    signal loop5b0AFinished
    signal loopA4eAFinished
    signal loop4b2BFinished
}
