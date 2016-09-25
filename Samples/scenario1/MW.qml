import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_mw
    initialState: comp_ae8_9_mw_mw
    //activate state machine
    running: true
    State {
        id: comp_ae8_9_mw_mw
        initialState: init_2a4_8_mw_mw
        SignalTransition {
            targetState: final_f7e_9_mw_mw
            signal: comp_ae8_9_mw_mw.finished
        }
        SignalTransition {
            targetState: comp_ae8_9_mw_mw
            signal: sp.resetOccured // reset_sp
        }
        SignalTransition {
            targetState: comp_ae8_9_mw_mw
            signal: resetButton.clicked
            guard: local.hasLock()
            onTriggered: {
                var data = mwmodel.reset()
                local.broadcastTransition("reset_mw", data)
                local.release()
            }
        }
        onEntered: {
            console.log("mw: comp_ae8_9_mw_mw entered")
            //update UI
            resetButton.enabled = true
        }
        onExited: {
            console.log("mw: comp_ae8_9_mw_mw exited")
            resetButton.enabled = false
        }
        State {
            id: init_2a4_8_mw_mw
            SignalTransition {
                targetState: selectAutomaticMode_finished_sp_mw_8cc_9
                signal: sp.selectautomaticmodeOccured // selectAutomaticMode_sp
            }
            SignalTransition {
                targetState: selectAutomaticMode_finished_mw_mw_2c2_8
                signal: autoButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("selectAutomaticMode_mw", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: selectManual_finished_sp_mw_fa4_b
                signal: sp.selectmanualOccured // selectManual_sp
            }
            SignalTransition {
                targetState: selectManual_finished_mw_mw_ada_b
                signal: manualButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("selectManual_mw", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("mw: init_2a4_8_mw_mw entered")
                //update UI
                resetButton.enabled = true
                autoButton.visible = true
                manualButton.visible = true
            }
            onExited: {
                console.log("mw: init_2a4_8_mw_mw exited")
                autoButton.visible = false
                manualButton.visible = false
            }
        }
        State {
            id: selectAutomaticMode_finished_sp_mw_8cc_9
            SignalTransition {
                targetState: selectPizza_finished_sp_mw_8cc_9
                signal: sp.selectpizzaOccured // selectPizza_sp
            }
            SignalTransition {
                targetState: cook_mw_mw_8cc_9_3ce_b
                signal: sp.selectfishOccured // selectFish_sp
            }
            onEntered: {
                console.log("mw_8cc_9: selectAutomaticMode_finished_sp_mw_8cc_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_8cc_9: selectAutomaticMode_finished_sp_mw_8cc_9 exited")
            }
        }
        State {
            id: selectPizza_finished_sp_mw_8cc_9
            SignalTransition {
                targetState: choosePizza_finished_sp_mw_8cc_9
                signal: sp.choosepizzaOccured // choosePizza_sp
            }
            onEntered: {
                console.log("mw_8cc_9: selectPizza_finished_sp_mw_8cc_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_8cc_9: selectPizza_finished_sp_mw_8cc_9 exited")
            }
        }
        State {
            id: choosePizza_finished_sp_mw_8cc_9
            SignalTransition {
                targetState: defrost_mw_mw_8cc_9_d06_b
                signal: sp.confirmselectedpizzaOccured // confirmSelectedPizza_sp
            }
            onEntered: {
                console.log("mw_8cc_9: choosePizza_finished_sp_mw_8cc_9 entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_8cc_9: choosePizza_finished_sp_mw_8cc_9 exited")
            }
        }
        State {
            id: defrost_mw_mw_8cc_9_d06_b
            SignalTransition {
                targetState: bake_mw_mw_8cc_9_d06_b
                signal: defrostFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_8cc_9_d06_b: defrost_mw_mw_8cc_9_d06_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.defrost(defrost_callback)
            }
            onExited: {
                console.log("mw_8cc_9_d06_b: defrost_mw_mw_8cc_9_d06_b exited")
                statusField.visible = false
            }
        }
        State {
            id: bake_mw_mw_8cc_9_d06_b
            SignalTransition {
                targetState: comp_33e_a_mw_mw_8cc_9_d06_b
                signal: bakeFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_8cc_9_d06_b: bake_mw_mw_8cc_9_d06_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.bake(bake_callback)
            }
            onExited: {
                console.log("mw_8cc_9_d06_b: bake_mw_mw_8cc_9_d06_b exited")
                statusField.visible = false
            }
        }
        State {
            id: comp_33e_a_mw_mw_8cc_9_d06_b
            initialState: par_99e_b_mw_8cc_9_d06_b_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.confirmAlarm()
                    local.broadcastTransition("confirmPizzaAlarm_mw", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmpizzaalarmOccured // confirmPizzaAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_33e_a_mw_mw_8cc_9_d06_b.finished
            }
            onEntered: {
                console.log("mw_8cc_9_d06_b: comp_33e_a_mw_mw_8cc_9_d06_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_8cc_9_d06_b: comp_33e_a_mw_mw_8cc_9_d06_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_99e_b_mw_8cc_9_d06_b_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_cce_a_mw_mw_8cc_9_d06_b
                    signal: par_99e_b_mw_8cc_9_d06_b_mw.finished
                }
                onEntered: {
                    console.log("mw_8cc_9_d06_b_mw: par_99e_b_mw_8cc_9_d06_b_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_8cc_9_d06_b_mw: par_99e_b_mw_8cc_9_d06_b_mw exited")
                }
                State {
                    id: comp_cb3_a_mw_mw_8cc_9_d06_b_mw_mw
                    initialState: notifyPizzaFinished_mw_mw_8cc_9_d06_b_mw_mw
                    onEntered: {
                        console.log("mw_8cc_9_d06_b_mw_mw: comp_cb3_a_mw_mw_8cc_9_d06_b_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_8cc_9_d06_b_mw_mw: comp_cb3_a_mw_mw_8cc_9_d06_b_mw_mw exited")
                    }
                    State {
                        id: notifyPizzaFinished_mw_mw_8cc_9_d06_b_mw_mw
                        SignalTransition {
                            targetState: final_f8d_8_mw_mw_8cc_9_d06_b_mw_mw
                            signal: notifypizzafinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_8cc_9_d06_b_mw_mw: notifyPizzaFinished_mw_mw_8cc_9_d06_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            statusField.visible = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.pizzaAlarm(notifyPizzaFinished_callback)
                        }
                        onExited: {
                            console.log("mw_8cc_9_d06_b_mw_mw: notifyPizzaFinished_mw_mw_8cc_9_d06_b_mw_mw exited")
                            statusField.visible = false
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_f8d_8_mw_mw_8cc_9_d06_b_mw_mw
                        onEntered: {
                            console.log("mw_8cc_9_d06_b_mw_mw: final_f8d_8_mw_mw_8cc_9_d06_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_d06_b_mw_mw: final_f8d_8_mw_mw_8cc_9_d06_b_mw_mw exited")
                        }
                    }
                }
                State {
                    id: comp_37e_b_mw_mw_8cc_9_d06_b_mw_sp
                    initialState: pending_4bc_b_sp_mw_8cc_9_d06_b_mw_sp
                    onEntered: {
                        console.log("mw_8cc_9_d06_b_mw_sp: comp_37e_b_mw_mw_8cc_9_d06_b_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_8cc_9_d06_b_mw_sp: comp_37e_b_mw_mw_8cc_9_d06_b_mw_sp exited")
                    }
                    State {
                        id: pending_4bc_b_sp_mw_8cc_9_d06_b_mw_sp
                        SignalTransition {
                            targetState: final_5e1_9_mw_mw_8cc_9_d06_b_mw_sp
                            signal: sp.notifypizzafinishedFinishedOccured // notifyPizzaFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_8cc_9_d06_b_mw_sp: pending_4bc_b_sp_mw_8cc_9_d06_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            statusField.visible = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_d06_b_mw_sp: pending_4bc_b_sp_mw_8cc_9_d06_b_mw_sp exited")
                            statusField.visible = false
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_5e1_9_mw_mw_8cc_9_d06_b_mw_sp
                        onEntered: {
                            console.log("mw_8cc_9_d06_b_mw_sp: final_5e1_9_mw_mw_8cc_9_d06_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_d06_b_mw_sp: final_5e1_9_mw_mw_8cc_9_d06_b_mw_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_cce_a_mw_mw_8cc_9_d06_b
                onEntered: {
                    console.log("mw_8cc_9_d06_b: final_cce_a_mw_mw_8cc_9_d06_b entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_8cc_9_d06_b: final_cce_a_mw_mw_8cc_9_d06_b exited")
                }
            }
        }
        FinalState {
            id: final_de7_b_mw_mw
            onEntered: {
                console.log("mw: final_de7_b_mw_mw entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw: final_de7_b_mw_mw exited")
            }
        }
        State {
            id: cook_mw_mw_8cc_9_3ce_b
            SignalTransition {
                targetState: comp_71c_8_mw_mw_8cc_9_3ce_b
                signal: cookFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_8cc_9_3ce_b: cook_mw_mw_8cc_9_3ce_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.cook(cook_callback)
            }
            onExited: {
                console.log("mw_8cc_9_3ce_b: cook_mw_mw_8cc_9_3ce_b exited")
                statusField.visible = false
            }
        }
        State {
            id: comp_71c_8_mw_mw_8cc_9_3ce_b
            initialState: par_a8f_b_mw_8cc_9_3ce_b_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmFishAlarm_mw", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmfishalarmOccured // confirmFishAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_71c_8_mw_mw_8cc_9_3ce_b.finished
            }
            onEntered: {
                console.log("mw_8cc_9_3ce_b: comp_71c_8_mw_mw_8cc_9_3ce_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_8cc_9_3ce_b: comp_71c_8_mw_mw_8cc_9_3ce_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_a8f_b_mw_8cc_9_3ce_b_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_946_a_mw_mw_8cc_9_3ce_b
                    signal: par_a8f_b_mw_8cc_9_3ce_b_mw.finished
                }
                onEntered: {
                    console.log("mw_8cc_9_3ce_b_mw: par_a8f_b_mw_8cc_9_3ce_b_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_8cc_9_3ce_b_mw: par_a8f_b_mw_8cc_9_3ce_b_mw exited")
                }
                State {
                    id: comp_174_b_mw_mw_8cc_9_3ce_b_mw_sp
                    initialState: pending_812_8_sp_mw_8cc_9_3ce_b_mw_sp
                    onEntered: {
                        console.log("mw_8cc_9_3ce_b_mw_sp: comp_174_b_mw_mw_8cc_9_3ce_b_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_8cc_9_3ce_b_mw_sp: comp_174_b_mw_mw_8cc_9_3ce_b_mw_sp exited")
                    }
                    State {
                        id: pending_812_8_sp_mw_8cc_9_3ce_b_mw_sp
                        SignalTransition {
                            targetState: final_cb7_b_mw_mw_8cc_9_3ce_b_mw_sp
                            signal: sp.notifyfishfinishedFinishedOccured // notifyFishFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_8cc_9_3ce_b_mw_sp: pending_812_8_sp_mw_8cc_9_3ce_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_3ce_b_mw_sp: pending_812_8_sp_mw_8cc_9_3ce_b_mw_sp exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_cb7_b_mw_mw_8cc_9_3ce_b_mw_sp
                        onEntered: {
                            console.log("mw_8cc_9_3ce_b_mw_sp: final_cb7_b_mw_mw_8cc_9_3ce_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_3ce_b_mw_sp: final_cb7_b_mw_mw_8cc_9_3ce_b_mw_sp exited")
                        }
                    }
                }
                State {
                    id: comp_4d8_b_mw_mw_8cc_9_3ce_b_mw_mw
                    initialState: notifyFishFinished_mw_mw_8cc_9_3ce_b_mw_mw
                    onEntered: {
                        console.log("mw_8cc_9_3ce_b_mw_mw: comp_4d8_b_mw_mw_8cc_9_3ce_b_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_8cc_9_3ce_b_mw_mw: comp_4d8_b_mw_mw_8cc_9_3ce_b_mw_mw exited")
                    }
                    State {
                        id: notifyFishFinished_mw_mw_8cc_9_3ce_b_mw_mw
                        SignalTransition {
                            targetState: final_eb0_a_mw_mw_8cc_9_3ce_b_mw_mw
                            signal: notifyfishfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_8cc_9_3ce_b_mw_mw: notifyFishFinished_mw_mw_8cc_9_3ce_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.fishAlarm(notifyFishFinished_callback)
                        }
                        onExited: {
                            console.log("mw_8cc_9_3ce_b_mw_mw: notifyFishFinished_mw_mw_8cc_9_3ce_b_mw_mw exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_eb0_a_mw_mw_8cc_9_3ce_b_mw_mw
                        onEntered: {
                            console.log("mw_8cc_9_3ce_b_mw_mw: final_eb0_a_mw_mw_8cc_9_3ce_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_8cc_9_3ce_b_mw_mw: final_eb0_a_mw_mw_8cc_9_3ce_b_mw_mw exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_946_a_mw_mw_8cc_9_3ce_b
                onEntered: {
                    console.log("mw_8cc_9_3ce_b: final_946_a_mw_mw_8cc_9_3ce_b entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_8cc_9_3ce_b: final_946_a_mw_mw_8cc_9_3ce_b exited")
                }
            }
        }
        State {
            id: selectAutomaticMode_finished_mw_mw_2c2_8
            SignalTransition {
                targetState: selectPizza_finished_mw_mw_2c2_8
                signal: pizzaButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("selectPizza_mw", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: cook_mw_mw_2c2_8_45f_8
                signal: fishButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("selectFish_mw", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_2c2_8: selectAutomaticMode_finished_mw_mw_2c2_8 entered")
                //update UI
                resetButton.enabled = true
                pizzaButton.visible = true
                fishButton.visible = true
            }
            onExited: {
                console.log("mw_2c2_8: selectAutomaticMode_finished_mw_mw_2c2_8 exited")
                pizzaButton.visible = false
                fishButton.visible = false
            }
        }
        State {
            id: selectPizza_finished_mw_mw_2c2_8
            SignalTransition {
                targetState: choosePizza_finished_mw_mw_2c2_8
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.choosePizza()
                    local.broadcastTransition("choosePizza_mw", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_2c2_8: selectPizza_finished_mw_mw_2c2_8 entered")
                //update UI
                resetButton.enabled = true
                pizzaGroupBox.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_2c2_8: selectPizza_finished_mw_mw_2c2_8 exited")
                pizzaGroupBox.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: choosePizza_finished_mw_mw_2c2_8
            SignalTransition {
                targetState: defrost_mw_mw_2c2_8_4c8_9
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.sendPizza()
                    local.broadcastTransition("confirmSelectedPizza_mw", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_2c2_8: choosePizza_finished_mw_mw_2c2_8 entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_2c2_8: choosePizza_finished_mw_mw_2c2_8 exited")
                statusField.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: defrost_mw_mw_2c2_8_4c8_9
            SignalTransition {
                targetState: bake_mw_mw_2c2_8_4c8_9
                signal: defrostFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_2c2_8_4c8_9: defrost_mw_mw_2c2_8_4c8_9 entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.defrost(defrost_callback)
            }
            onExited: {
                console.log("mw_2c2_8_4c8_9: defrost_mw_mw_2c2_8_4c8_9 exited")
                statusField.visible = false
            }
        }
        State {
            id: bake_mw_mw_2c2_8_4c8_9
            SignalTransition {
                targetState: comp_8bd_9_mw_mw_2c2_8_4c8_9
                signal: bakeFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_2c2_8_4c8_9: bake_mw_mw_2c2_8_4c8_9 entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.bake(bake_callback)
            }
            onExited: {
                console.log("mw_2c2_8_4c8_9: bake_mw_mw_2c2_8_4c8_9 exited")
                statusField.visible = false
            }
        }
        State {
            id: comp_8bd_9_mw_mw_2c2_8_4c8_9
            initialState: par_ef7_a_mw_2c2_8_4c8_9_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.confirmAlarm()
                    local.broadcastTransition("confirmPizzaAlarm_mw", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmpizzaalarmOccured // confirmPizzaAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_8bd_9_mw_mw_2c2_8_4c8_9.finished
            }
            onEntered: {
                console.log("mw_2c2_8_4c8_9: comp_8bd_9_mw_mw_2c2_8_4c8_9 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_2c2_8_4c8_9: comp_8bd_9_mw_mw_2c2_8_4c8_9 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_ef7_a_mw_2c2_8_4c8_9_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_109_b_mw_mw_2c2_8_4c8_9
                    signal: par_ef7_a_mw_2c2_8_4c8_9_mw.finished
                }
                onEntered: {
                    console.log("mw_2c2_8_4c8_9_mw: par_ef7_a_mw_2c2_8_4c8_9_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_2c2_8_4c8_9_mw: par_ef7_a_mw_2c2_8_4c8_9_mw exited")
                }
                State {
                    id: comp_71e_8_mw_mw_2c2_8_4c8_9_mw_mw
                    initialState: notifyPizzaFinished_mw_mw_2c2_8_4c8_9_mw_mw
                    onEntered: {
                        console.log("mw_2c2_8_4c8_9_mw_mw: comp_71e_8_mw_mw_2c2_8_4c8_9_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_2c2_8_4c8_9_mw_mw: comp_71e_8_mw_mw_2c2_8_4c8_9_mw_mw exited")
                    }
                    State {
                        id: notifyPizzaFinished_mw_mw_2c2_8_4c8_9_mw_mw
                        SignalTransition {
                            targetState: final_4cf_a_mw_mw_2c2_8_4c8_9_mw_mw
                            signal: notifypizzafinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_2c2_8_4c8_9_mw_mw: notifyPizzaFinished_mw_mw_2c2_8_4c8_9_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            statusField.visible = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.pizzaAlarm(notifyPizzaFinished_callback)
                        }
                        onExited: {
                            console.log("mw_2c2_8_4c8_9_mw_mw: notifyPizzaFinished_mw_mw_2c2_8_4c8_9_mw_mw exited")
                            statusField.visible = false
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_4cf_a_mw_mw_2c2_8_4c8_9_mw_mw
                        onEntered: {
                            console.log("mw_2c2_8_4c8_9_mw_mw: final_4cf_a_mw_mw_2c2_8_4c8_9_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_4c8_9_mw_mw: final_4cf_a_mw_mw_2c2_8_4c8_9_mw_mw exited")
                        }
                    }
                }
                State {
                    id: comp_4d2_b_mw_mw_2c2_8_4c8_9_mw_sp
                    initialState: pending_dec_8_sp_mw_2c2_8_4c8_9_mw_sp
                    onEntered: {
                        console.log("mw_2c2_8_4c8_9_mw_sp: comp_4d2_b_mw_mw_2c2_8_4c8_9_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_2c2_8_4c8_9_mw_sp: comp_4d2_b_mw_mw_2c2_8_4c8_9_mw_sp exited")
                    }
                    State {
                        id: pending_dec_8_sp_mw_2c2_8_4c8_9_mw_sp
                        SignalTransition {
                            targetState: final_362_b_mw_mw_2c2_8_4c8_9_mw_sp
                            signal: sp.notifypizzafinishedFinishedOccured // notifyPizzaFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_2c2_8_4c8_9_mw_sp: pending_dec_8_sp_mw_2c2_8_4c8_9_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            statusField.visible = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_4c8_9_mw_sp: pending_dec_8_sp_mw_2c2_8_4c8_9_mw_sp exited")
                            statusField.visible = false
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_362_b_mw_mw_2c2_8_4c8_9_mw_sp
                        onEntered: {
                            console.log("mw_2c2_8_4c8_9_mw_sp: final_362_b_mw_mw_2c2_8_4c8_9_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_4c8_9_mw_sp: final_362_b_mw_mw_2c2_8_4c8_9_mw_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_109_b_mw_mw_2c2_8_4c8_9
                onEntered: {
                    console.log("mw_2c2_8_4c8_9: final_109_b_mw_mw_2c2_8_4c8_9 entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_2c2_8_4c8_9: final_109_b_mw_mw_2c2_8_4c8_9 exited")
                }
            }
        }
        State {
            id: cook_mw_mw_2c2_8_45f_8
            SignalTransition {
                targetState: comp_61a_b_mw_mw_2c2_8_45f_8
                signal: cookFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_2c2_8_45f_8: cook_mw_mw_2c2_8_45f_8 entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.cook(cook_callback)
            }
            onExited: {
                console.log("mw_2c2_8_45f_8: cook_mw_mw_2c2_8_45f_8 exited")
                statusField.visible = false
            }
        }
        State {
            id: comp_61a_b_mw_mw_2c2_8_45f_8
            initialState: par_1bb_b_mw_2c2_8_45f_8_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirmFishAlarm_mw", "")
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmfishalarmOccured // confirmFishAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_61a_b_mw_mw_2c2_8_45f_8.finished
            }
            onEntered: {
                console.log("mw_2c2_8_45f_8: comp_61a_b_mw_mw_2c2_8_45f_8 entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_2c2_8_45f_8: comp_61a_b_mw_mw_2c2_8_45f_8 exited")
                confirmButton.enabled = false
            }
            State {
                id: par_1bb_b_mw_2c2_8_45f_8_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_006_b_mw_mw_2c2_8_45f_8
                    signal: par_1bb_b_mw_2c2_8_45f_8_mw.finished
                }
                onEntered: {
                    console.log("mw_2c2_8_45f_8_mw: par_1bb_b_mw_2c2_8_45f_8_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_2c2_8_45f_8_mw: par_1bb_b_mw_2c2_8_45f_8_mw exited")
                }
                State {
                    id: comp_7f4_8_mw_mw_2c2_8_45f_8_mw_sp
                    initialState: pending_e33_a_sp_mw_2c2_8_45f_8_mw_sp
                    onEntered: {
                        console.log("mw_2c2_8_45f_8_mw_sp: comp_7f4_8_mw_mw_2c2_8_45f_8_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_2c2_8_45f_8_mw_sp: comp_7f4_8_mw_mw_2c2_8_45f_8_mw_sp exited")
                    }
                    State {
                        id: pending_e33_a_sp_mw_2c2_8_45f_8_mw_sp
                        SignalTransition {
                            targetState: final_6bc_a_mw_mw_2c2_8_45f_8_mw_sp
                            signal: sp.notifyfishfinishedFinishedOccured // notifyFishFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_2c2_8_45f_8_mw_sp: pending_e33_a_sp_mw_2c2_8_45f_8_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_45f_8_mw_sp: pending_e33_a_sp_mw_2c2_8_45f_8_mw_sp exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_6bc_a_mw_mw_2c2_8_45f_8_mw_sp
                        onEntered: {
                            console.log("mw_2c2_8_45f_8_mw_sp: final_6bc_a_mw_mw_2c2_8_45f_8_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_45f_8_mw_sp: final_6bc_a_mw_mw_2c2_8_45f_8_mw_sp exited")
                        }
                    }
                }
                State {
                    id: comp_5a7_a_mw_mw_2c2_8_45f_8_mw_mw
                    initialState: notifyFishFinished_mw_mw_2c2_8_45f_8_mw_mw
                    onEntered: {
                        console.log("mw_2c2_8_45f_8_mw_mw: comp_5a7_a_mw_mw_2c2_8_45f_8_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_2c2_8_45f_8_mw_mw: comp_5a7_a_mw_mw_2c2_8_45f_8_mw_mw exited")
                    }
                    State {
                        id: notifyFishFinished_mw_mw_2c2_8_45f_8_mw_mw
                        SignalTransition {
                            targetState: final_53f_9_mw_mw_2c2_8_45f_8_mw_mw
                            signal: notifyfishfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_2c2_8_45f_8_mw_mw: notifyFishFinished_mw_mw_2c2_8_45f_8_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.fishAlarm(notifyFishFinished_callback)
                        }
                        onExited: {
                            console.log("mw_2c2_8_45f_8_mw_mw: notifyFishFinished_mw_mw_2c2_8_45f_8_mw_mw exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_53f_9_mw_mw_2c2_8_45f_8_mw_mw
                        onEntered: {
                            console.log("mw_2c2_8_45f_8_mw_mw: final_53f_9_mw_mw_2c2_8_45f_8_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_2c2_8_45f_8_mw_mw: final_53f_9_mw_mw_2c2_8_45f_8_mw_mw exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_006_b_mw_mw_2c2_8_45f_8
                onEntered: {
                    console.log("mw_2c2_8_45f_8: final_006_b_mw_mw_2c2_8_45f_8 entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_2c2_8_45f_8: final_006_b_mw_mw_2c2_8_45f_8 exited")
                }
            }
        }
        State {
            id: selectManual_finished_sp_mw_fa4_b
            SignalTransition {
                targetState: setMinutes_finished_sp_mw_fa4_b
                signal: sp.setminutesOccured // setMinutes_sp
            }
            onEntered: {
                console.log("mw_fa4_b: selectManual_finished_sp_mw_fa4_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_fa4_b: selectManual_finished_sp_mw_fa4_b exited")
            }
        }
        State {
            id: setMinutes_finished_sp_mw_fa4_b
            SignalTransition {
                targetState: setSeconds_finished_sp_mw_fa4_b
                signal: sp.setsecondsOccured // setSeconds_sp
            }
            onEntered: {
                console.log("mw_fa4_b: setMinutes_finished_sp_mw_fa4_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_fa4_b: setMinutes_finished_sp_mw_fa4_b exited")
            }
        }
        State {
            id: setSeconds_finished_sp_mw_fa4_b
            SignalTransition {
                targetState: pending_6e5_a_sp_mw_fa4_b
                signal: sp.setpowerOccured // setPower_sp
            }
            onEntered: {
                console.log("mw_fa4_b: setSeconds_finished_sp_mw_fa4_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_fa4_b: setSeconds_finished_sp_mw_fa4_b exited")
            }
        }
        State {
            id: pending_6e5_a_sp_mw_fa4_b
            SignalTransition {
                targetState: showConfiguration_finished_finished_sp_mw_fa4_b
                signal: sp.showconfigurationFinishedOccured // showConfiguration_finished_sp
            }
            onEntered: {
                console.log("mw_fa4_b: pending_6e5_a_sp_mw_fa4_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
            }
            onExited: {
                console.log("mw_fa4_b: pending_6e5_a_sp_mw_fa4_b exited")
                statusField.visible = false
            }
        }
        State {
            id: showConfiguration_finished_finished_sp_mw_fa4_b
            SignalTransition {
                targetState: enableHeater_mw_mw_fa4_b_e35_b
                signal: sp.confirmOccured // confirm_sp
            }
            onEntered: {
                console.log("mw_fa4_b: showConfiguration_finished_finished_sp_mw_fa4_b entered")
                //update UI
                resetButton.enabled = true
            }
            onExited: {
                console.log("mw_fa4_b: showConfiguration_finished_finished_sp_mw_fa4_b exited")
            }
        }
        State {
            id: enableHeater_mw_mw_fa4_b_e35_b
            SignalTransition {
                targetState: countdown_mw_mw_fa4_b_e35_b
                signal: enableheaterFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_fa4_b_e35_b: enableHeater_mw_mw_fa4_b_e35_b entered")
                //update UI
                resetButton.enabled = true
                //execute hooks, i.e. actual behavior code
                mwmodel.enableHeater(enableHeater_callback)
            }
            onExited: {
                console.log("mw_fa4_b_e35_b: enableHeater_mw_mw_fa4_b_e35_b exited")
            }
        }
        State {
            id: countdown_mw_mw_fa4_b_e35_b
            SignalTransition {
                targetState: disableHeater_mw_mw_fa4_b_e35_b
                signal: countdownFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_fa4_b_e35_b: countdown_mw_mw_fa4_b_e35_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.countdown(countdown_callback)
            }
            onExited: {
                console.log("mw_fa4_b_e35_b: countdown_mw_mw_fa4_b_e35_b exited")
                statusField.visible = false
            }
        }
        State {
            id: disableHeater_mw_mw_fa4_b_e35_b
            SignalTransition {
                targetState: comp_9f0_a_mw_mw_fa4_b_e35_b
                signal: disableheaterFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_fa4_b_e35_b: disableHeater_mw_mw_fa4_b_e35_b entered")
                //update UI
                resetButton.enabled = true
                //execute hooks, i.e. actual behavior code
                mwmodel.disableHeater(disableHeater_callback)
            }
            onExited: {
                console.log("mw_fa4_b_e35_b: disableHeater_mw_mw_fa4_b_e35_b exited")
            }
        }
        State {
            id: comp_9f0_a_mw_mw_fa4_b_e35_b
            initialState: par_036_8_mw_fa4_b_e35_b_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.confirmAlarm()
                    local.broadcastTransition("confirmManualAlarm_mw", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmmanualalarmOccured // confirmManualAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_9f0_a_mw_mw_fa4_b_e35_b.finished
            }
            onEntered: {
                console.log("mw_fa4_b_e35_b: comp_9f0_a_mw_mw_fa4_b_e35_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_fa4_b_e35_b: comp_9f0_a_mw_mw_fa4_b_e35_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_036_8_mw_fa4_b_e35_b_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_8c4_8_mw_mw_fa4_b_e35_b
                    signal: par_036_8_mw_fa4_b_e35_b_mw.finished
                }
                onEntered: {
                    console.log("mw_fa4_b_e35_b_mw: par_036_8_mw_fa4_b_e35_b_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_fa4_b_e35_b_mw: par_036_8_mw_fa4_b_e35_b_mw exited")
                }
                State {
                    id: comp_f6a_8_mw_mw_fa4_b_e35_b_mw_mw
                    initialState: notifyManualFinished_mw_mw_fa4_b_e35_b_mw_mw
                    onEntered: {
                        console.log("mw_fa4_b_e35_b_mw_mw: comp_f6a_8_mw_mw_fa4_b_e35_b_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_fa4_b_e35_b_mw_mw: comp_f6a_8_mw_mw_fa4_b_e35_b_mw_mw exited")
                    }
                    State {
                        id: notifyManualFinished_mw_mw_fa4_b_e35_b_mw_mw
                        SignalTransition {
                            targetState: final_219_8_mw_mw_fa4_b_e35_b_mw_mw
                            signal: notifymanualfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_fa4_b_e35_b_mw_mw: notifyManualFinished_mw_mw_fa4_b_e35_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.manualAlarm(notifyManualFinished_callback)
                        }
                        onExited: {
                            console.log("mw_fa4_b_e35_b_mw_mw: notifyManualFinished_mw_mw_fa4_b_e35_b_mw_mw exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_219_8_mw_mw_fa4_b_e35_b_mw_mw
                        onEntered: {
                            console.log("mw_fa4_b_e35_b_mw_mw: final_219_8_mw_mw_fa4_b_e35_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_fa4_b_e35_b_mw_mw: final_219_8_mw_mw_fa4_b_e35_b_mw_mw exited")
                        }
                    }
                }
                State {
                    id: comp_b52_8_mw_mw_fa4_b_e35_b_mw_sp
                    initialState: pending_34f_a_sp_mw_fa4_b_e35_b_mw_sp
                    onEntered: {
                        console.log("mw_fa4_b_e35_b_mw_sp: comp_b52_8_mw_mw_fa4_b_e35_b_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_fa4_b_e35_b_mw_sp: comp_b52_8_mw_mw_fa4_b_e35_b_mw_sp exited")
                    }
                    State {
                        id: pending_34f_a_sp_mw_fa4_b_e35_b_mw_sp
                        SignalTransition {
                            targetState: final_1ee_8_mw_mw_fa4_b_e35_b_mw_sp
                            signal: sp.notifymanualfinishedFinishedOccured // notifyManualFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_fa4_b_e35_b_mw_sp: pending_34f_a_sp_mw_fa4_b_e35_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_fa4_b_e35_b_mw_sp: pending_34f_a_sp_mw_fa4_b_e35_b_mw_sp exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_1ee_8_mw_mw_fa4_b_e35_b_mw_sp
                        onEntered: {
                            console.log("mw_fa4_b_e35_b_mw_sp: final_1ee_8_mw_mw_fa4_b_e35_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_fa4_b_e35_b_mw_sp: final_1ee_8_mw_mw_fa4_b_e35_b_mw_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_8c4_8_mw_mw_fa4_b_e35_b
                onEntered: {
                    console.log("mw_fa4_b_e35_b: final_8c4_8_mw_mw_fa4_b_e35_b entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_fa4_b_e35_b: final_8c4_8_mw_mw_fa4_b_e35_b exited")
                }
            }
        }
        State {
            id: selectManual_finished_mw_mw_ada_b
            SignalTransition {
                targetState: setMinutes_finished_mw_mw_ada_b
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.getMinutes()
                    local.broadcastTransition("setMinutes_mw", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_ada_b: selectManual_finished_mw_mw_ada_b entered")
                //update UI
                resetButton.enabled = true
                minInput.visible = true
                minInputText.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_ada_b: selectManual_finished_mw_mw_ada_b exited")
                minInput.visible = false
                minInputText.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: setMinutes_finished_mw_mw_ada_b
            SignalTransition {
                targetState: setSeconds_finished_mw_mw_ada_b
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.getSeconds()
                    local.broadcastTransition("setSeconds_mw", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_ada_b: setMinutes_finished_mw_mw_ada_b entered")
                //update UI
                resetButton.enabled = true
                secInput.visible = true
                secInputText.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_ada_b: setMinutes_finished_mw_mw_ada_b exited")
                secInput.visible = false
                secInputText.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: setSeconds_finished_mw_mw_ada_b
            SignalTransition {
                targetState: showConfiguration_mw_mw_ada_b
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.getPower()
                    local.broadcastTransition("setPower_mw", data)
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_ada_b: setSeconds_finished_mw_mw_ada_b entered")
                //update UI
                resetButton.enabled = true
                powerInput.visible = true
                powerInputText.visible = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_ada_b: setSeconds_finished_mw_mw_ada_b exited")
                powerInput.visible = false
                powerInputText.visible = false
                confirmButton.enabled = false
            }
        }
        State {
            id: showConfiguration_mw_mw_ada_b
            SignalTransition {
                targetState: showConfiguration_finished_finished_mw_mw_ada_b
                signal: showconfigurationFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_ada_b: showConfiguration_mw_mw_ada_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.showConfiguration(showConfiguration_callback)
            }
            onExited: {
                console.log("mw_ada_b: showConfiguration_mw_mw_ada_b exited")
                statusField.visible = false
            }
        }
        State {
            id: showConfiguration_finished_finished_mw_mw_ada_b
            SignalTransition {
                targetState: enableHeater_mw_mw_ada_b_b10_b
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    local.broadcastTransition("confirm_mw", "")
                    local.release()
                }
            }
            onEntered: {
                console.log("mw_ada_b: showConfiguration_finished_finished_mw_mw_ada_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_ada_b: showConfiguration_finished_finished_mw_mw_ada_b exited")
                confirmButton.enabled = false
            }
        }
        State {
            id: enableHeater_mw_mw_ada_b_b10_b
            SignalTransition {
                targetState: countdown_mw_mw_ada_b_b10_b
                signal: enableheaterFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_ada_b_b10_b: enableHeater_mw_mw_ada_b_b10_b entered")
                //update UI
                resetButton.enabled = true
                //execute hooks, i.e. actual behavior code
                mwmodel.enableHeater(enableHeater_callback)
            }
            onExited: {
                console.log("mw_ada_b_b10_b: enableHeater_mw_mw_ada_b_b10_b exited")
            }
        }
        State {
            id: countdown_mw_mw_ada_b_b10_b
            SignalTransition {
                targetState: disableHeater_mw_mw_ada_b_b10_b
                signal: countdownFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_ada_b_b10_b: countdown_mw_mw_ada_b_b10_b entered")
                //update UI
                resetButton.enabled = true
                statusField.visible = true
                //execute hooks, i.e. actual behavior code
                mwmodel.countdown(countdown_callback)
            }
            onExited: {
                console.log("mw_ada_b_b10_b: countdown_mw_mw_ada_b_b10_b exited")
                statusField.visible = false
            }
        }
        State {
            id: disableHeater_mw_mw_ada_b_b10_b
            SignalTransition {
                targetState: comp_87a_b_mw_mw_ada_b_b10_b
                signal: disableheaterFinished
                onTriggered: {
                }
            }
            onEntered: {
                console.log("mw_ada_b_b10_b: disableHeater_mw_mw_ada_b_b10_b entered")
                //update UI
                resetButton.enabled = true
                //execute hooks, i.e. actual behavior code
                mwmodel.disableHeater(disableHeater_callback)
            }
            onExited: {
                console.log("mw_ada_b_b10_b: disableHeater_mw_mw_ada_b_b10_b exited")
            }
        }
        State {
            id: comp_87a_b_mw_mw_ada_b_b10_b
            initialState: par_5c3_8_mw_ada_b_b10_b_mw
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: confirmButton.clicked
                guard: local.hasLock()
                onTriggered: {
                    var data = mwmodel.confirmAlarm()
                    local.broadcastTransition("confirmManualAlarm_mw", data)
                    local.release()
                }
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: sp.confirmmanualalarmOccured // confirmManualAlarm_sp
            }
            SignalTransition {
                targetState: final_de7_b_mw_mw
                signal: comp_87a_b_mw_mw_ada_b_b10_b.finished
            }
            onEntered: {
                console.log("mw_ada_b_b10_b: comp_87a_b_mw_mw_ada_b_b10_b entered")
                //update UI
                resetButton.enabled = true
                confirmButton.enabled = true
            }
            onExited: {
                console.log("mw_ada_b_b10_b: comp_87a_b_mw_mw_ada_b_b10_b exited")
                confirmButton.enabled = false
            }
            State {
                id: par_5c3_8_mw_ada_b_b10_b_mw
                childMode: QState.ParallelStates
                SignalTransition {
                    targetState: final_3d1_9_mw_mw_ada_b_b10_b
                    signal: par_5c3_8_mw_ada_b_b10_b_mw.finished
                }
                onEntered: {
                    console.log("mw_ada_b_b10_b_mw: par_5c3_8_mw_ada_b_b10_b_mw entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_ada_b_b10_b_mw: par_5c3_8_mw_ada_b_b10_b_mw exited")
                }
                State {
                    id: comp_02e_8_mw_mw_ada_b_b10_b_mw_mw
                    initialState: notifyManualFinished_mw_mw_ada_b_b10_b_mw_mw
                    onEntered: {
                        console.log("mw_ada_b_b10_b_mw_mw: comp_02e_8_mw_mw_ada_b_b10_b_mw_mw entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_ada_b_b10_b_mw_mw: comp_02e_8_mw_mw_ada_b_b10_b_mw_mw exited")
                    }
                    State {
                        id: notifyManualFinished_mw_mw_ada_b_b10_b_mw_mw
                        SignalTransition {
                            targetState: final_d4c_9_mw_mw_ada_b_b10_b_mw_mw
                            signal: notifymanualfinishedFinished
                            onTriggered: {
                            }
                        }
                        onEntered: {
                            console.log("mw_ada_b_b10_b_mw_mw: notifyManualFinished_mw_mw_ada_b_b10_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                            //execute hooks, i.e. actual behavior code
                            mwmodel.manualAlarm(notifyManualFinished_callback)
                        }
                        onExited: {
                            console.log("mw_ada_b_b10_b_mw_mw: notifyManualFinished_mw_mw_ada_b_b10_b_mw_mw exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_d4c_9_mw_mw_ada_b_b10_b_mw_mw
                        onEntered: {
                            console.log("mw_ada_b_b10_b_mw_mw: final_d4c_9_mw_mw_ada_b_b10_b_mw_mw entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_ada_b_b10_b_mw_mw: final_d4c_9_mw_mw_ada_b_b10_b_mw_mw exited")
                        }
                    }
                }
                State {
                    id: comp_75b_8_mw_mw_ada_b_b10_b_mw_sp
                    initialState: pending_bb6_b_sp_mw_ada_b_b10_b_mw_sp
                    onEntered: {
                        console.log("mw_ada_b_b10_b_mw_sp: comp_75b_8_mw_mw_ada_b_b10_b_mw_sp entered")
                        //update UI
                        resetButton.enabled = true
                        confirmButton.enabled = true
                    }
                    onExited: {
                        console.log("mw_ada_b_b10_b_mw_sp: comp_75b_8_mw_mw_ada_b_b10_b_mw_sp exited")
                    }
                    State {
                        id: pending_bb6_b_sp_mw_ada_b_b10_b_mw_sp
                        SignalTransition {
                            targetState: final_e82_a_mw_mw_ada_b_b10_b_mw_sp
                            signal: sp.notifymanualfinishedFinishedOccured // notifyManualFinished_finished_sp
                        }
                        onEntered: {
                            console.log("mw_ada_b_b10_b_mw_sp: pending_bb6_b_sp_mw_ada_b_b10_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                            bell.visible = true
                        }
                        onExited: {
                            console.log("mw_ada_b_b10_b_mw_sp: pending_bb6_b_sp_mw_ada_b_b10_b_mw_sp exited")
                            bell.visible = false
                        }
                    }
                    FinalState {
                        id: final_e82_a_mw_mw_ada_b_b10_b_mw_sp
                        onEntered: {
                            console.log("mw_ada_b_b10_b_mw_sp: final_e82_a_mw_mw_ada_b_b10_b_mw_sp entered")
                            //update UI
                            resetButton.enabled = true
                            confirmButton.enabled = true
                        }
                        onExited: {
                            console.log("mw_ada_b_b10_b_mw_sp: final_e82_a_mw_mw_ada_b_b10_b_mw_sp exited")
                        }
                    }
                }
            }
            FinalState {
                id: final_3d1_9_mw_mw_ada_b_b10_b
                onEntered: {
                    console.log("mw_ada_b_b10_b: final_3d1_9_mw_mw_ada_b_b10_b entered")
                    //update UI
                    resetButton.enabled = true
                    confirmButton.enabled = true
                }
                onExited: {
                    console.log("mw_ada_b_b10_b: final_3d1_9_mw_mw_ada_b_b10_b exited")
                }
            }
        }
    }
    FinalState {
        id: final_f7e_9_mw_mw
        onEntered: {
            console.log("mw: final_f7e_9_mw_mw entered")
            //update UI
        }
        onExited: {
            console.log("mw: final_f7e_9_mw_mw exited")
        }
    }
    function notifyManualFinished_callback(){
        local.broadcastTransition("notifyManualFinished_finished_mw", "")
        notifymanualfinishedFinished()
    }
    function cook_callback(){
        local.broadcastTransition("cook_finished_mw", "")
        cookFinished()
    }
    function showConfiguration_callback(){
        local.broadcastTransition("showConfiguration_finished_mw", "")
        showconfigurationFinished()
    }
    function enableHeater_callback(){
        local.broadcastTransition("enableHeater_finished_mw", "")
        enableheaterFinished()
    }
    function notifyPizzaFinished_callback(){
        local.broadcastTransition("notifyPizzaFinished_finished_mw", "")
        notifypizzafinishedFinished()
    }
    function disableHeater_callback(){
        local.broadcastTransition("disableHeater_finished_mw", "")
        disableheaterFinished()
    }
    function defrost_callback(){
        local.broadcastTransition("defrost_finished_mw", "")
        defrostFinished()
    }
    function countdown_callback(){
        local.broadcastTransition("countdown_finished_mw", "")
        countdownFinished()
    }
    function notifyFishFinished_callback(){
        local.broadcastTransition("notifyFishFinished_finished_mw", "")
        notifyfishfinishedFinished()
    }
    function bake_callback(){
        local.broadcastTransition("bake_finished_mw", "")
        bakeFinished()
    }
    signal notifymanualfinishedFinished
    signal cookFinished
    signal showconfigurationFinished
    signal enableheaterFinished
    signal notifypizzafinishedFinished
    signal disableheaterFinished
    signal defrostFinished
    signal countdownFinished
    signal notifyfishfinishedFinished
    signal bakeFinished
}
