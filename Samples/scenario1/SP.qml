import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_sp
    initialState: comp_6c6_8_sp_sp
    //activate state machine
    running: true
    State {
        id: comp_6c6_8_sp_sp
        initialState: init_cd3_b_sp_sp
        SignalTransition {
            targetState: final_58b_8_sp_sp
            signal: comp_6c6_8_sp_sp.finished
        }
        SignalTransition {
            targetState: comp_6c6_8_sp_sp
            signal: resetButton.clicked
            guard: local.hasLock()
            onTriggered: {
                var data = spmodel.reset()
                local.broadcastTransition("reset_sp", data)
                local.release()
            }
        }
        SignalTransition {
            targetState: comp_6c6_8_sp_sp
            signal: mw.resetOccured // reset_mw
        }
        onEntered: {
            console.log("sp: comp_6c6_8_sp_sp entered")
            //update UI
            resetButton.enabled = true
        }
        onExited: {
            console.log("sp: comp_6c6_8_sp_sp exited")
            resetButton.enabled = false
        }
        State {
            id: init_cd3_b_sp_sp
            SignalTransition {
                targetState: selectAutomaticMode_finished_sp_sp_7af_8
                signal: confirmButton.clicked
                guard: local.hasLock() && modeCombo.currentText === "auto mode"
                onTriggered: {
                    local.broadcastTransition("selectAutomaticMode_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: selectAutomaticMode_finished_mw_sp_d1a_a
                signal: mw.selectautomaticmodeOccured // selectAutomaticMode_mw
            }
            SignalTransition {
                targetState: selectManual_finished_sp_sp_78e_9
                signal: confirmButton.clicked
                guard: local.hasLock() && modeCombo.currentText === "manual mode"
                onTriggered: {
                    local.broadcastTransition("selectManual_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: selectManual_finished_mw_sp_aca_a
                signal: mw.selectmanualOccured // selectManual_mw
            }
            onEntered: {
                console.log("sp: init_cd3_b_sp_sp entered")
                //update UI
                resetButton.enabled = true
                modeCombo.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp: init_cd3_b_sp_sp exited")
                modeCombo.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: selectAutomaticMode_finished_sp_sp_7af_8
            SignalTransition {
                targetState: selectPizza_finished_sp_sp_7af_8
                signal: confirmButton.clicked
                guard: local.hasLock() && foodCombo.currentText === "Pizza"
                onTriggered: {
                    local.broadcastTransition("selectPizza_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: pending_fcc_9_mw_sp_7af_8_c26_b
                signal: confirmButton.clicked
                guard: local.hasLock() && foodCombo.currentText === "Fish"
                onTriggered: {
                    local.broadcastTransition("selectFish_sp", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_7af_8: selectAutomaticMode_finished_sp_sp_7af_8 entered")
                //update UI
                resetButton.enabled = true
                foodCombo.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8: selectAutomaticMode_finished_sp_sp_7af_8 exited")
                foodCombo.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: selectPizza_finished_sp_sp_7af_8
            SignalTransition {
                targetState: choosePizza_finished_sp_sp_7af_8
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.showSelectedPizza()
                    local.broadcastTransition("choosePizza_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_7af_8: selectPizza_finished_sp_sp_7af_8 entered")
                //update UI
                resetButton.enabled = true
                pizzaCombo.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8: selectPizza_finished_sp_sp_7af_8 exited")
                pizzaCombo.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: choosePizza_finished_sp_sp_7af_8
            SignalTransition {
                targetState: pending_226_9_mw_sp_7af_8_68c_8
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.getSelectedPizza()
                    local.broadcastTransition("confirmSelectedPizza_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_7af_8: choosePizza_finished_sp_sp_7af_8 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8: choosePizza_finished_sp_sp_7af_8 exited")
                confirmButton.enabled = false
            }
        }
        State {
            id: pending_226_9_mw_sp_7af_8_68c_8
            SignalTransition {
                targetState: pending_a49_a_mw_sp_7af_8_68c_8
                signal: mw.defrostFinishedOccured // defrost_finished_mw
            }
            onEntered: {
                console.log("sp_7af_8_68c_8: pending_226_9_mw_sp_7af_8_68c_8 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8_68c_8: pending_226_9_mw_sp_7af_8_68c_8 exited")
            }
        }
        State {
            id: pending_a49_a_mw_sp_7af_8_68c_8
            SignalTransition {
                targetState: comp_8cc_8_mw_sp_7af_8_68c_8
                signal: mw.bakeFinishedOccured // bake_finished_mw
            }
            onEntered: {
                console.log("sp_7af_8_68c_8: pending_a49_a_mw_sp_7af_8_68c_8 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8_68c_8: pending_a49_a_mw_sp_7af_8_68c_8 exited")
            }
        }
        State {
            id: comp_8cc_8_mw_sp_7af_8_68c_8
            initialState: par_709_9_sp_7af_8_68c_8_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmpizzaalarmOccured // confirmPizzaAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmPizzaAlarm_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_8cc_8_mw_sp_7af_8_68c_8.finished
            }
            onEntered: {
                console.log("sp_7af_8_68c_8: comp_8cc_8_mw_sp_7af_8_68c_8 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8_68c_8: comp_8cc_8_mw_sp_7af_8_68c_8 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_709_9_sp_7af_8_68c_8_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_979_8_mw_sp_7af_8_68c_8
                    signal: par_709_9_sp_7af_8_68c_8_sp.finished
                }
                onEntered: {
                    console.log("sp_7af_8_68c_8_sp: par_709_9_sp_7af_8_68c_8_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_7af_8_68c_8_sp: par_709_9_sp_7af_8_68c_8_sp exited")
                }
                State {
                    id: comp_bbb_9_mw_sp_7af_8_68c_8_sp_mw
                    initialState: pending_059_8_mw_sp_7af_8_68c_8_sp_mw
                    onEntered: {
                        console.log("sp_7af_8_68c_8_sp_mw: comp_bbb_9_mw_sp_7af_8_68c_8_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_7af_8_68c_8_sp_mw: comp_bbb_9_mw_sp_7af_8_68c_8_sp_mw exited")
                    }
                    State {
                        id: pending_059_8_mw_sp_7af_8_68c_8_sp_mw
                        SignalTransition {
                            targetState: final_bf8_a_mw_sp_7af_8_68c_8_sp_mw
                            signal: mw.notifypizzafinishedFinishedOccured // notifyPizzaFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_7af_8_68c_8_sp_mw: pending_059_8_mw_sp_7af_8_68c_8_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_7af_8_68c_8_sp_mw: pending_059_8_mw_sp_7af_8_68c_8_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_bf8_a_mw_sp_7af_8_68c_8_sp_mw
                        onEntered: {
                            console.log("sp_7af_8_68c_8_sp_mw: final_bf8_a_mw_sp_7af_8_68c_8_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_7af_8_68c_8_sp_mw: final_bf8_a_mw_sp_7af_8_68c_8_sp_mw exited")
                        }
                    }
                }
                State {
                    id: comp_17e_9_mw_sp_7af_8_68c_8_sp_sp
                    initialState: notifyPizzaFinished_sp_sp_7af_8_68c_8_sp_sp
                    onEntered: {
                        console.log("sp_7af_8_68c_8_sp_sp: comp_17e_9_mw_sp_7af_8_68c_8_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_7af_8_68c_8_sp_sp: comp_17e_9_mw_sp_7af_8_68c_8_sp_sp exited")
                    }
                    State {
                        id: notifyPizzaFinished_sp_sp_7af_8_68c_8_sp_sp
                        SignalTransition {
                            targetState: final_a57_8_mw_sp_7af_8_68c_8_sp_sp
                            signal: notifypizzafinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_7af_8_68c_8_sp_sp: notifyPizzaFinished_sp_sp_7af_8_68c_8_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyPizzaFinished(notifyPizzaFinished_callback)
                        }
                        onExited: {
                            console.log("sp_7af_8_68c_8_sp_sp: notifyPizzaFinished_sp_sp_7af_8_68c_8_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_a57_8_mw_sp_7af_8_68c_8_sp_sp
                        onEntered: {
                            console.log("sp_7af_8_68c_8_sp_sp: final_a57_8_mw_sp_7af_8_68c_8_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_7af_8_68c_8_sp_sp: final_a57_8_mw_sp_7af_8_68c_8_sp_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_979_8_mw_sp_7af_8_68c_8
                onEntered: {
                    console.log("sp_7af_8_68c_8: final_979_8_mw_sp_7af_8_68c_8 entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_7af_8_68c_8: final_979_8_mw_sp_7af_8_68c_8 exited")
                }
            }
        }
        FinalState {
            id: final_92b_a_sp_sp
            onEntered: {
                console.log("sp: final_92b_a_sp_sp entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp: final_92b_a_sp_sp exited")
            }
        }
        State {
            id: pending_fcc_9_mw_sp_7af_8_c26_b
            SignalTransition {
                targetState: comp_054_8_mw_sp_7af_8_c26_b
                signal: mw.cookFinishedOccured // cook_finished_mw
            }
            onEntered: {
                console.log("sp_7af_8_c26_b: pending_fcc_9_mw_sp_7af_8_c26_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8_c26_b: pending_fcc_9_mw_sp_7af_8_c26_b exited")
            }
        }
        State {
            id: comp_054_8_mw_sp_7af_8_c26_b
            initialState: par_3fe_9_sp_7af_8_c26_b_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmfishalarmOccured // confirmFishAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmFishAlarm_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_054_8_mw_sp_7af_8_c26_b.finished
            }
            onEntered: {
                console.log("sp_7af_8_c26_b: comp_054_8_mw_sp_7af_8_c26_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_7af_8_c26_b: comp_054_8_mw_sp_7af_8_c26_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_3fe_9_sp_7af_8_c26_b_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_34f_a_mw_sp_7af_8_c26_b
                    signal: par_3fe_9_sp_7af_8_c26_b_sp.finished
                }
                onEntered: {
                    console.log("sp_7af_8_c26_b_sp: par_3fe_9_sp_7af_8_c26_b_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_7af_8_c26_b_sp: par_3fe_9_sp_7af_8_c26_b_sp exited")
                }
                State {
                    id: comp_49d_8_mw_sp_7af_8_c26_b_sp_sp
                    initialState: notifyFishFinished_sp_sp_7af_8_c26_b_sp_sp
                    onEntered: {
                        console.log("sp_7af_8_c26_b_sp_sp: comp_49d_8_mw_sp_7af_8_c26_b_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_7af_8_c26_b_sp_sp: comp_49d_8_mw_sp_7af_8_c26_b_sp_sp exited")
                    }
                    State {
                        id: notifyFishFinished_sp_sp_7af_8_c26_b_sp_sp
                        SignalTransition {
                            targetState: final_522_8_mw_sp_7af_8_c26_b_sp_sp
                            signal: notifyfishfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_7af_8_c26_b_sp_sp: notifyFishFinished_sp_sp_7af_8_c26_b_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyFishFinished(notifyFishFinished_callback)
                        }
                        onExited: {
                            console.log("sp_7af_8_c26_b_sp_sp: notifyFishFinished_sp_sp_7af_8_c26_b_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_522_8_mw_sp_7af_8_c26_b_sp_sp
                        onEntered: {
                            console.log("sp_7af_8_c26_b_sp_sp: final_522_8_mw_sp_7af_8_c26_b_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_7af_8_c26_b_sp_sp: final_522_8_mw_sp_7af_8_c26_b_sp_sp exited")
                        }
                    }
                }
                State {
                    id: comp_5ac_a_mw_sp_7af_8_c26_b_sp_mw
                    initialState: pending_b35_9_mw_sp_7af_8_c26_b_sp_mw
                    onEntered: {
                        console.log("sp_7af_8_c26_b_sp_mw: comp_5ac_a_mw_sp_7af_8_c26_b_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_7af_8_c26_b_sp_mw: comp_5ac_a_mw_sp_7af_8_c26_b_sp_mw exited")
                    }
                    State {
                        id: pending_b35_9_mw_sp_7af_8_c26_b_sp_mw
                        SignalTransition {
                            targetState: final_6a4_b_mw_sp_7af_8_c26_b_sp_mw
                            signal: mw.notifyfishfinishedFinishedOccured // notifyFishFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_7af_8_c26_b_sp_mw: pending_b35_9_mw_sp_7af_8_c26_b_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_7af_8_c26_b_sp_mw: pending_b35_9_mw_sp_7af_8_c26_b_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_6a4_b_mw_sp_7af_8_c26_b_sp_mw
                        onEntered: {
                            console.log("sp_7af_8_c26_b_sp_mw: final_6a4_b_mw_sp_7af_8_c26_b_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_7af_8_c26_b_sp_mw: final_6a4_b_mw_sp_7af_8_c26_b_sp_mw exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_34f_a_mw_sp_7af_8_c26_b
                onEntered: {
                    console.log("sp_7af_8_c26_b: final_34f_a_mw_sp_7af_8_c26_b entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_7af_8_c26_b: final_34f_a_mw_sp_7af_8_c26_b exited")
                }
            }
        }
        State {
            id: selectAutomaticMode_finished_mw_sp_d1a_a
            SignalTransition {
                targetState: selectPizza_finished_mw_sp_d1a_a
                signal: mw.selectpizzaOccured // selectPizza_mw
            }
            SignalTransition {
                targetState: pending_87d_8_mw_sp_d1a_a_605_8
                signal: mw.selectfishOccured // selectFish_mw
            }
            onEntered: {
                console.log("sp_d1a_a: selectAutomaticMode_finished_mw_sp_d1a_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a: selectAutomaticMode_finished_mw_sp_d1a_a exited")
            }
        }
        State {
            id: selectPizza_finished_mw_sp_d1a_a
            SignalTransition {
                targetState: choosePizza_finished_mw_sp_d1a_a
                signal: mw.choosepizzaOccured // choosePizza_mw
            }
            onEntered: {
                console.log("sp_d1a_a: selectPizza_finished_mw_sp_d1a_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a: selectPizza_finished_mw_sp_d1a_a exited")
            }
        }
        State {
            id: choosePizza_finished_mw_sp_d1a_a
            SignalTransition {
                targetState: pending_a97_a_mw_sp_d1a_a_052_b
                signal: mw.confirmselectedpizzaOccured // confirmSelectedPizza_mw
            }
            onEntered: {
                console.log("sp_d1a_a: choosePizza_finished_mw_sp_d1a_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a: choosePizza_finished_mw_sp_d1a_a exited")
            }
        }
        State {
            id: pending_a97_a_mw_sp_d1a_a_052_b
            SignalTransition {
                targetState: pending_831_a_mw_sp_d1a_a_052_b
                signal: mw.defrostFinishedOccured // defrost_finished_mw
            }
            onEntered: {
                console.log("sp_d1a_a_052_b: pending_a97_a_mw_sp_d1a_a_052_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a_052_b: pending_a97_a_mw_sp_d1a_a_052_b exited")
            }
        }
        State {
            id: pending_831_a_mw_sp_d1a_a_052_b
            SignalTransition {
                targetState: comp_984_b_mw_sp_d1a_a_052_b
                signal: mw.bakeFinishedOccured // bake_finished_mw
            }
            onEntered: {
                console.log("sp_d1a_a_052_b: pending_831_a_mw_sp_d1a_a_052_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a_052_b: pending_831_a_mw_sp_d1a_a_052_b exited")
            }
        }
        State {
            id: comp_984_b_mw_sp_d1a_a_052_b
            initialState: par_5a0_a_sp_d1a_a_052_b_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmpizzaalarmOccured // confirmPizzaAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmPizzaAlarm_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_984_b_mw_sp_d1a_a_052_b.finished
            }
            onEntered: {
                console.log("sp_d1a_a_052_b: comp_984_b_mw_sp_d1a_a_052_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a_052_b: comp_984_b_mw_sp_d1a_a_052_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_5a0_a_sp_d1a_a_052_b_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_d0e_9_mw_sp_d1a_a_052_b
                    signal: par_5a0_a_sp_d1a_a_052_b_sp.finished
                }
                onEntered: {
                    console.log("sp_d1a_a_052_b_sp: par_5a0_a_sp_d1a_a_052_b_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_d1a_a_052_b_sp: par_5a0_a_sp_d1a_a_052_b_sp exited")
                }
                State {
                    id: comp_590_9_mw_sp_d1a_a_052_b_sp_mw
                    initialState: pending_fe6_8_mw_sp_d1a_a_052_b_sp_mw
                    onEntered: {
                        console.log("sp_d1a_a_052_b_sp_mw: comp_590_9_mw_sp_d1a_a_052_b_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_d1a_a_052_b_sp_mw: comp_590_9_mw_sp_d1a_a_052_b_sp_mw exited")
                    }
                    State {
                        id: pending_fe6_8_mw_sp_d1a_a_052_b_sp_mw
                        SignalTransition {
                            targetState: final_e2f_b_mw_sp_d1a_a_052_b_sp_mw
                            signal: mw.notifypizzafinishedFinishedOccured // notifyPizzaFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_d1a_a_052_b_sp_mw: pending_fe6_8_mw_sp_d1a_a_052_b_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_052_b_sp_mw: pending_fe6_8_mw_sp_d1a_a_052_b_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_e2f_b_mw_sp_d1a_a_052_b_sp_mw
                        onEntered: {
                            console.log("sp_d1a_a_052_b_sp_mw: final_e2f_b_mw_sp_d1a_a_052_b_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_052_b_sp_mw: final_e2f_b_mw_sp_d1a_a_052_b_sp_mw exited")
                        }
                    }
                }
                State {
                    id: comp_c1d_9_mw_sp_d1a_a_052_b_sp_sp
                    initialState: notifyPizzaFinished_sp_sp_d1a_a_052_b_sp_sp
                    onEntered: {
                        console.log("sp_d1a_a_052_b_sp_sp: comp_c1d_9_mw_sp_d1a_a_052_b_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_d1a_a_052_b_sp_sp: comp_c1d_9_mw_sp_d1a_a_052_b_sp_sp exited")
                    }
                    State {
                        id: notifyPizzaFinished_sp_sp_d1a_a_052_b_sp_sp
                        SignalTransition {
                            targetState: final_4ce_8_mw_sp_d1a_a_052_b_sp_sp
                            signal: notifypizzafinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_d1a_a_052_b_sp_sp: notifyPizzaFinished_sp_sp_d1a_a_052_b_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyPizzaFinished(notifyPizzaFinished_callback)
                        }
                        onExited: {
                            console.log("sp_d1a_a_052_b_sp_sp: notifyPizzaFinished_sp_sp_d1a_a_052_b_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_4ce_8_mw_sp_d1a_a_052_b_sp_sp
                        onEntered: {
                            console.log("sp_d1a_a_052_b_sp_sp: final_4ce_8_mw_sp_d1a_a_052_b_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_052_b_sp_sp: final_4ce_8_mw_sp_d1a_a_052_b_sp_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_d0e_9_mw_sp_d1a_a_052_b
                onEntered: {
                    console.log("sp_d1a_a_052_b: final_d0e_9_mw_sp_d1a_a_052_b entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_d1a_a_052_b: final_d0e_9_mw_sp_d1a_a_052_b exited")
                }
            }
        }
        State {
            id: pending_87d_8_mw_sp_d1a_a_605_8
            SignalTransition {
                targetState: comp_1af_9_mw_sp_d1a_a_605_8
                signal: mw.cookFinishedOccured // cook_finished_mw
            }
            onEntered: {
                console.log("sp_d1a_a_605_8: pending_87d_8_mw_sp_d1a_a_605_8 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a_605_8: pending_87d_8_mw_sp_d1a_a_605_8 exited")
            }
        }
        State {
            id: comp_1af_9_mw_sp_d1a_a_605_8
            initialState: par_0e1_8_sp_d1a_a_605_8_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmfishalarmOccured // confirmFishAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmFishAlarm_sp", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_1af_9_mw_sp_d1a_a_605_8.finished
            }
            onEntered: {
                console.log("sp_d1a_a_605_8: comp_1af_9_mw_sp_d1a_a_605_8 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_d1a_a_605_8: comp_1af_9_mw_sp_d1a_a_605_8 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_0e1_8_sp_d1a_a_605_8_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_b16_8_mw_sp_d1a_a_605_8
                    signal: par_0e1_8_sp_d1a_a_605_8_sp.finished
                }
                onEntered: {
                    console.log("sp_d1a_a_605_8_sp: par_0e1_8_sp_d1a_a_605_8_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_d1a_a_605_8_sp: par_0e1_8_sp_d1a_a_605_8_sp exited")
                }
                State {
                    id: comp_f02_9_mw_sp_d1a_a_605_8_sp_sp
                    initialState: notifyFishFinished_sp_sp_d1a_a_605_8_sp_sp
                    onEntered: {
                        console.log("sp_d1a_a_605_8_sp_sp: comp_f02_9_mw_sp_d1a_a_605_8_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_d1a_a_605_8_sp_sp: comp_f02_9_mw_sp_d1a_a_605_8_sp_sp exited")
                    }
                    State {
                        id: notifyFishFinished_sp_sp_d1a_a_605_8_sp_sp
                        SignalTransition {
                            targetState: final_08e_9_mw_sp_d1a_a_605_8_sp_sp
                            signal: notifyfishfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_d1a_a_605_8_sp_sp: notifyFishFinished_sp_sp_d1a_a_605_8_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyFishFinished(notifyFishFinished_callback)
                        }
                        onExited: {
                            console.log("sp_d1a_a_605_8_sp_sp: notifyFishFinished_sp_sp_d1a_a_605_8_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_08e_9_mw_sp_d1a_a_605_8_sp_sp
                        onEntered: {
                            console.log("sp_d1a_a_605_8_sp_sp: final_08e_9_mw_sp_d1a_a_605_8_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_605_8_sp_sp: final_08e_9_mw_sp_d1a_a_605_8_sp_sp exited")
                        }
                    }
                }
                State {
                    id: comp_fbb_b_mw_sp_d1a_a_605_8_sp_mw
                    initialState: pending_5cf_9_mw_sp_d1a_a_605_8_sp_mw
                    onEntered: {
                        console.log("sp_d1a_a_605_8_sp_mw: comp_fbb_b_mw_sp_d1a_a_605_8_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_d1a_a_605_8_sp_mw: comp_fbb_b_mw_sp_d1a_a_605_8_sp_mw exited")
                    }
                    State {
                        id: pending_5cf_9_mw_sp_d1a_a_605_8_sp_mw
                        SignalTransition {
                            targetState: final_298_8_mw_sp_d1a_a_605_8_sp_mw
                            signal: mw.notifyfishfinishedFinishedOccured // notifyFishFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_d1a_a_605_8_sp_mw: pending_5cf_9_mw_sp_d1a_a_605_8_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_605_8_sp_mw: pending_5cf_9_mw_sp_d1a_a_605_8_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_298_8_mw_sp_d1a_a_605_8_sp_mw
                        onEntered: {
                            console.log("sp_d1a_a_605_8_sp_mw: final_298_8_mw_sp_d1a_a_605_8_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_d1a_a_605_8_sp_mw: final_298_8_mw_sp_d1a_a_605_8_sp_mw exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_b16_8_mw_sp_d1a_a_605_8
                onEntered: {
                    console.log("sp_d1a_a_605_8: final_b16_8_mw_sp_d1a_a_605_8 entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_d1a_a_605_8: final_b16_8_mw_sp_d1a_a_605_8 exited")
                }
            }
        }
        State {
            id: selectManual_finished_sp_sp_78e_9
            SignalTransition {
                targetState: setMinutes_finished_sp_sp_78e_9
                signal: minInput.editingFinished
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.getMinutes()
                    local.broadcastTransition("setMinutes_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_78e_9: selectManual_finished_sp_sp_78e_9 entered")
                //update UI
                resetButton.enabled = true
                secInput.visible = true
                powerInput.visible = true
                minInput.visible = true
            }
            onExited: {
                console.log("sp_78e_9: selectManual_finished_sp_sp_78e_9 exited")
                secInput.visible = false
                powerInput.visible = false
                minInput.visible = false
            }
        }
        State {
            id: setMinutes_finished_sp_sp_78e_9
            SignalTransition {
                targetState: setSeconds_finished_sp_sp_78e_9
                signal: secInput.editingFinished
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.getSeconds()
                    local.broadcastTransition("setSeconds_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_78e_9: setMinutes_finished_sp_sp_78e_9 entered")
                //update UI
                resetButton.enabled = true
                minInput.visible = true
                powerInput.visible = true
                secInput.visible = true
            }
            onExited: {
                console.log("sp_78e_9: setMinutes_finished_sp_sp_78e_9 exited")
                minInput.visible = false
                powerInput.visible = false
                secInput.visible = false
            }
        }
        State {
            id: setSeconds_finished_sp_sp_78e_9
            SignalTransition {
                targetState: showConfiguration_sp_sp_78e_9
                signal: powerInput.editingFinished
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.getPower()
                    local.broadcastTransition("setPower_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_78e_9: setSeconds_finished_sp_sp_78e_9 entered")
                //update UI
                resetButton.enabled = true
                secInput.visible = true
                minInput.visible = true
                powerInput.visible = true
            }
            onExited: {
                console.log("sp_78e_9: setSeconds_finished_sp_sp_78e_9 exited")
                secInput.visible = false
                minInput.visible = false
                powerInput.visible = false
            }
        }
        State {
            id: showConfiguration_sp_sp_78e_9
            SignalTransition {
                targetState: showConfiguration_finished_finished_sp_sp_78e_9
                signal: showconfigurationFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("sp_78e_9: showConfiguration_sp_sp_78e_9 entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                spmodel.showConfiguration(showConfiguration_callback)
            }
            onExited: {
                console.log("sp_78e_9: showConfiguration_sp_sp_78e_9 exited")
                statusField.visible = false
            }
        }
        State {
            id: showConfiguration_finished_finished_sp_sp_78e_9
            SignalTransition {
                targetState: pending_1b7_b_mw_sp_78e_9_96b_9
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.confirmConfiguration()
                    local.broadcastTransition("confirm_sp", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("sp_78e_9: showConfiguration_finished_finished_sp_sp_78e_9 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_78e_9: showConfiguration_finished_finished_sp_sp_78e_9 exited")
                confirmButton.enabled = false
            }
        }
        State {
            id: pending_1b7_b_mw_sp_78e_9_96b_9
            SignalTransition {
                targetState: pending_1fa_8_mw_sp_78e_9_96b_9
                signal: mw.enableheaterFinishedOccured // enableHeater_finished_mw
            }
            onEntered: {
                console.log("sp_78e_9_96b_9: pending_1b7_b_mw_sp_78e_9_96b_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_78e_9_96b_9: pending_1b7_b_mw_sp_78e_9_96b_9 exited")
            }
        }
        State {
            id: pending_1fa_8_mw_sp_78e_9_96b_9
            SignalTransition {
                targetState: pending_826_9_mw_sp_78e_9_96b_9
                signal: mw.countdownFinishedOccured // countdown_finished_mw
            }
            onEntered: {
                console.log("sp_78e_9_96b_9: pending_1fa_8_mw_sp_78e_9_96b_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_78e_9_96b_9: pending_1fa_8_mw_sp_78e_9_96b_9 exited")
            }
        }
        State {
            id: pending_826_9_mw_sp_78e_9_96b_9
            SignalTransition {
                targetState: comp_df7_a_mw_sp_78e_9_96b_9
                signal: mw.disableheaterFinishedOccured // disableHeater_finished_mw
            }
            onEntered: {
                console.log("sp_78e_9_96b_9: pending_826_9_mw_sp_78e_9_96b_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_78e_9_96b_9: pending_826_9_mw_sp_78e_9_96b_9 exited")
            }
        }
        State {
            id: comp_df7_a_mw_sp_78e_9_96b_9
            initialState: par_58f_9_sp_78e_9_96b_9_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmmanualalarmOccured // confirmManualAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.confirmAlarm()
                    local.broadcastTransition("confirmManualAlarm_sp", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_df7_a_mw_sp_78e_9_96b_9.finished
            }
            onEntered: {
                console.log("sp_78e_9_96b_9: comp_df7_a_mw_sp_78e_9_96b_9 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_78e_9_96b_9: comp_df7_a_mw_sp_78e_9_96b_9 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_58f_9_sp_78e_9_96b_9_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_e5d_a_mw_sp_78e_9_96b_9
                    signal: par_58f_9_sp_78e_9_96b_9_sp.finished
                }
                onEntered: {
                    console.log("sp_78e_9_96b_9_sp: par_58f_9_sp_78e_9_96b_9_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_78e_9_96b_9_sp: par_58f_9_sp_78e_9_96b_9_sp exited")
                }
                State {
                    id: comp_1d7_a_mw_sp_78e_9_96b_9_sp_mw
                    initialState: pending_ef2_8_mw_sp_78e_9_96b_9_sp_mw
                    onEntered: {
                        console.log("sp_78e_9_96b_9_sp_mw: comp_1d7_a_mw_sp_78e_9_96b_9_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_78e_9_96b_9_sp_mw: comp_1d7_a_mw_sp_78e_9_96b_9_sp_mw exited")
                    }
                    State {
                        id: pending_ef2_8_mw_sp_78e_9_96b_9_sp_mw
                        SignalTransition {
                            targetState: final_338_a_mw_sp_78e_9_96b_9_sp_mw
                            signal: mw.notifymanualfinishedFinishedOccured // notifyManualFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_78e_9_96b_9_sp_mw: pending_ef2_8_mw_sp_78e_9_96b_9_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_78e_9_96b_9_sp_mw: pending_ef2_8_mw_sp_78e_9_96b_9_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_338_a_mw_sp_78e_9_96b_9_sp_mw
                        onEntered: {
                            console.log("sp_78e_9_96b_9_sp_mw: final_338_a_mw_sp_78e_9_96b_9_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_78e_9_96b_9_sp_mw: final_338_a_mw_sp_78e_9_96b_9_sp_mw exited")
                        }
                    }
                }
                State {
                    id: comp_b94_b_mw_sp_78e_9_96b_9_sp_sp
                    initialState: notifyManualFinished_sp_sp_78e_9_96b_9_sp_sp
                    onEntered: {
                        console.log("sp_78e_9_96b_9_sp_sp: comp_b94_b_mw_sp_78e_9_96b_9_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_78e_9_96b_9_sp_sp: comp_b94_b_mw_sp_78e_9_96b_9_sp_sp exited")
                    }
                    State {
                        id: notifyManualFinished_sp_sp_78e_9_96b_9_sp_sp
                        SignalTransition {
                            targetState: final_447_8_mw_sp_78e_9_96b_9_sp_sp
                            signal: notifymanualfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_78e_9_96b_9_sp_sp: notifyManualFinished_sp_sp_78e_9_96b_9_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyManualFinished(notifyManualFinished_callback)
                        }
                        onExited: {
                            console.log("sp_78e_9_96b_9_sp_sp: notifyManualFinished_sp_sp_78e_9_96b_9_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_447_8_mw_sp_78e_9_96b_9_sp_sp
                        onEntered: {
                            console.log("sp_78e_9_96b_9_sp_sp: final_447_8_mw_sp_78e_9_96b_9_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_78e_9_96b_9_sp_sp: final_447_8_mw_sp_78e_9_96b_9_sp_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_e5d_a_mw_sp_78e_9_96b_9
                onEntered: {
                    console.log("sp_78e_9_96b_9: final_e5d_a_mw_sp_78e_9_96b_9 entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_78e_9_96b_9: final_e5d_a_mw_sp_78e_9_96b_9 exited")
                }
            }
        }
        State {
            id: selectManual_finished_mw_sp_aca_a
            SignalTransition {
                targetState: setMinutes_finished_mw_sp_aca_a
                signal: mw.setminutesOccured // setMinutes_mw
            }
            onEntered: {
                console.log("sp_aca_a: selectManual_finished_mw_sp_aca_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a: selectManual_finished_mw_sp_aca_a exited")
            }
        }
        State {
            id: setMinutes_finished_mw_sp_aca_a
            SignalTransition {
                targetState: setSeconds_finished_mw_sp_aca_a
                signal: mw.setsecondsOccured // setSeconds_mw
            }
            onEntered: {
                console.log("sp_aca_a: setMinutes_finished_mw_sp_aca_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a: setMinutes_finished_mw_sp_aca_a exited")
            }
        }
        State {
            id: setSeconds_finished_mw_sp_aca_a
            SignalTransition {
                targetState: pending_087_8_mw_sp_aca_a
                signal: mw.setpowerOccured // setPower_mw
            }
            onEntered: {
                console.log("sp_aca_a: setSeconds_finished_mw_sp_aca_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a: setSeconds_finished_mw_sp_aca_a exited")
            }
        }
        State {
            id: pending_087_8_mw_sp_aca_a
            SignalTransition {
                targetState: showConfiguration_finished_finished_mw_sp_aca_a
                signal: mw.showconfigurationFinishedOccured // showConfiguration_finished_mw
            }
            onEntered: {
                console.log("sp_aca_a: pending_087_8_mw_sp_aca_a entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
            }
            onExited: {
                console.log("sp_aca_a: pending_087_8_mw_sp_aca_a exited")
                statusField.visible = false
            }
        }
        State {
            id: showConfiguration_finished_finished_mw_sp_aca_a
            SignalTransition {
                targetState: pending_4e2_b_mw_sp_aca_a_a62_9
                signal: mw.confirmOccured // confirm_mw
            }
            onEntered: {
                console.log("sp_aca_a: showConfiguration_finished_finished_mw_sp_aca_a entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a: showConfiguration_finished_finished_mw_sp_aca_a exited")
            }
        }
        State {
            id: pending_4e2_b_mw_sp_aca_a_a62_9
            SignalTransition {
                targetState: pending_05c_8_mw_sp_aca_a_a62_9
                signal: mw.enableheaterFinishedOccured // enableHeater_finished_mw
            }
            onEntered: {
                console.log("sp_aca_a_a62_9: pending_4e2_b_mw_sp_aca_a_a62_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a_a62_9: pending_4e2_b_mw_sp_aca_a_a62_9 exited")
            }
        }
        State {
            id: pending_05c_8_mw_sp_aca_a_a62_9
            SignalTransition {
                targetState: pending_9c8_9_mw_sp_aca_a_a62_9
                signal: mw.countdownFinishedOccured // countdown_finished_mw
            }
            onEntered: {
                console.log("sp_aca_a_a62_9: pending_05c_8_mw_sp_aca_a_a62_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a_a62_9: pending_05c_8_mw_sp_aca_a_a62_9 exited")
            }
        }
        State {
            id: pending_9c8_9_mw_sp_aca_a_a62_9
            SignalTransition {
                targetState: comp_293_b_mw_sp_aca_a_a62_9
                signal: mw.disableheaterFinishedOccured // disableHeater_finished_mw
            }
            onEntered: {
                console.log("sp_aca_a_a62_9: pending_9c8_9_mw_sp_aca_a_a62_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a_a62_9: pending_9c8_9_mw_sp_aca_a_a62_9 exited")
            }
        }
        State {
            id: comp_293_b_mw_sp_aca_a_a62_9
            initialState: par_a92_a_sp_aca_a_a62_9_sp
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: mw.confirmmanualalarmOccured // confirmManualAlarm_mw
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = spmodel.confirmAlarm()
                    local.broadcastTransition("confirmManualAlarm_sp", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_92b_a_sp_sp
                signal: comp_293_b_mw_sp_aca_a_a62_9.finished
            }
            onEntered: {
                console.log("sp_aca_a_a62_9: comp_293_b_mw_sp_aca_a_a62_9 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("sp_aca_a_a62_9: comp_293_b_mw_sp_aca_a_a62_9 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_a92_a_sp_aca_a_a62_9_sp
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_7ca_a_mw_sp_aca_a_a62_9
                    signal: par_a92_a_sp_aca_a_a62_9_sp.finished
                }
                onEntered: {
                    console.log("sp_aca_a_a62_9_sp: par_a92_a_sp_aca_a_a62_9_sp entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_aca_a_a62_9_sp: par_a92_a_sp_aca_a_a62_9_sp exited")
                }
                State {
                    id: comp_e13_b_mw_sp_aca_a_a62_9_sp_mw
                    initialState: pending_16f_9_mw_sp_aca_a_a62_9_sp_mw
                    onEntered: {
                        console.log("sp_aca_a_a62_9_sp_mw: comp_e13_b_mw_sp_aca_a_a62_9_sp_mw entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_aca_a_a62_9_sp_mw: comp_e13_b_mw_sp_aca_a_a62_9_sp_mw exited")
                    }
                    State {
                        id: pending_16f_9_mw_sp_aca_a_a62_9_sp_mw
                        SignalTransition {
                            targetState: final_9b9_9_mw_sp_aca_a_a62_9_sp_mw
                            signal: mw.notifymanualfinishedFinishedOccured // notifyManualFinished_finished_mw
                        }
                        onEntered: {
                            console.log("sp_aca_a_a62_9_sp_mw: pending_16f_9_mw_sp_aca_a_a62_9_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                        }
                        onExited: {
                            console.log("sp_aca_a_a62_9_sp_mw: pending_16f_9_mw_sp_aca_a_a62_9_sp_mw exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_9b9_9_mw_sp_aca_a_a62_9_sp_mw
                        onEntered: {
                            console.log("sp_aca_a_a62_9_sp_mw: final_9b9_9_mw_sp_aca_a_a62_9_sp_mw entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_aca_a_a62_9_sp_mw: final_9b9_9_mw_sp_aca_a_a62_9_sp_mw exited")
                        }
                    }
                }
                State {
                    id: comp_d42_9_mw_sp_aca_a_a62_9_sp_sp
                    initialState: notifyManualFinished_sp_sp_aca_a_a62_9_sp_sp
                    onEntered: {
                        console.log("sp_aca_a_a62_9_sp_sp: comp_d42_9_mw_sp_aca_a_a62_9_sp_sp entered")
                        //update UI
                        confirmButton.enabled = true
                        resetButton.enabled = true
                    }
                    onExited: {
                        console.log("sp_aca_a_a62_9_sp_sp: comp_d42_9_mw_sp_aca_a_a62_9_sp_sp exited")
                    }
                    State {
                        id: notifyManualFinished_sp_sp_aca_a_a62_9_sp_sp
                        SignalTransition {
                            targetState: final_61f_b_mw_sp_aca_a_a62_9_sp_sp
                            signal: notifymanualfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("sp_aca_a_a62_9_sp_sp: notifyManualFinished_sp_sp_aca_a_a62_9_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                            bell.visible = true
                            statusField.visible = true
                            //execute hooks, i.e. actual behavior code
                            spmodel.notifyManualFinished(notifyManualFinished_callback)
                        }
                        onExited: {
                            console.log("sp_aca_a_a62_9_sp_sp: notifyManualFinished_sp_sp_aca_a_a62_9_sp_sp exited")
                            bell.visible = false
                            statusField.visible = false
                        }
                    }
                    FinalState {
                        id: final_61f_b_mw_sp_aca_a_a62_9_sp_sp
                        onEntered: {
                            console.log("sp_aca_a_a62_9_sp_sp: final_61f_b_mw_sp_aca_a_a62_9_sp_sp entered")
                            //update UI
                            confirmButton.enabled = true
                            resetButton.enabled = true
                        }
                        onExited: {
                            console.log("sp_aca_a_a62_9_sp_sp: final_61f_b_mw_sp_aca_a_a62_9_sp_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_7ca_a_mw_sp_aca_a_a62_9
                onEntered: {
                    console.log("sp_aca_a_a62_9: final_7ca_a_mw_sp_aca_a_a62_9 entered")
                    //update UI
                    confirmButton.enabled = true
                    resetButton.enabled = true
                }
                onExited: {
                    console.log("sp_aca_a_a62_9: final_7ca_a_mw_sp_aca_a_a62_9 exited")
                }
            }
        }
    }
    FinalState {
        id: final_58b_8_sp_sp
        onEntered: {
            console.log("sp: final_58b_8_sp_sp entered")
            //update UI
        }
        onExited: {
            console.log("sp: final_58b_8_sp_sp exited")
        }
    }
    function notifyPizzaFinished_callback(){
        local.broadcastTransition("notifyPizzaFinished_finished_sp", "")
        notifypizzafinishedFinished()
    }
    function notifyFishFinished_callback(){
        local.broadcastTransition("notifyFishFinished_finished_sp", "")
        notifyfishfinishedFinished()
    }
    function showConfiguration_callback(){
        local.broadcastTransition("showConfiguration_finished_sp", "")
        showconfigurationFinished()
    }
    function notifyManualFinished_callback(){
        local.broadcastTransition("notifyManualFinished_finished_sp", "")
        notifymanualfinishedFinished()
    }
    signal notifypizzafinishedFinished
    signal notifyfishfinishedFinished
    signal showconfigurationFinished
    signal notifymanualfinishedFinished
}
