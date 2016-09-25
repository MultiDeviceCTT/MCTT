import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_md
    initialState: init_0f4_8_md_md
    //activate state machine
    running: true
    State {
        id: init_0f4_8_md_md
        SignalTransition {
            targetState: selectPizza_finished_mw_md_f12_9
            signal: mw.selectpizzaOccured // selectPizza_mw
        }
        SignalTransition {
            targetState: selectPizza_finished_md_md_9e2_9
            signal: pizzaButton.clicked
            guard: local.hasLock()
            onTriggered: {
                local.broadcastTransition("selectPizza_md", "")
                local.release()
            }
        }
        SignalTransition {
            targetState: selectCookingMode_finished_mw_md_8ce_b
            signal: mw.selectcookingmodeOccured // selectCookingMode_mw
        }
        onEntered: {
            console.log("md: init_0f4_8_md_md entered")
            //update UI
            confirmButton.visible = true
            testButton.enabled = true
            xCombo.enabled = true
            pizzaButton.visible = true
        }
        onExited: {
            console.log("md: init_0f4_8_md_md exited")
            confirmButton.visible = false
            testButton.enabled = false
            xCombo.enabled = false
            pizzaButton.visible = false
        }
    }
    State {
        id: selectPizza_finished_mw_md_f12_9
        SignalTransition {
            targetState: pending_5a7_a_mw_md_f12_9_f4f_8
            signal: mw.confirmpizzaselectionOccured // confirmPizzaSelection_mw
        }
        onEntered: {
            console.log("md_f12_9: selectPizza_finished_mw_md_f12_9 entered")
            //update UI
        }
        onExited: {
            console.log("md_f12_9: selectPizza_finished_mw_md_f12_9 exited")
        }
    }
    State {
        id: pending_5a7_a_mw_md_f12_9_f4f_8
        SignalTransition {
            targetState: pending_331_b_mw_md_f12_9_f4f_8
            signal: mw.defrostFinishedOccured // defrost_finished_mw
        }
        onEntered: {
            console.log("md_f12_9_f4f_8: pending_5a7_a_mw_md_f12_9_f4f_8 entered")
            //update UI
        }
        onExited: {
            console.log("md_f12_9_f4f_8: pending_5a7_a_mw_md_f12_9_f4f_8 exited")
        }
    }
    State {
        id: pending_331_b_mw_md_f12_9_f4f_8
        SignalTransition {
            targetState: final_eba_a_md_md
            signal: mw.cookFinishedOccured // cook_finished_mw
        }
        onEntered: {
            console.log("md_f12_9_f4f_8: pending_331_b_mw_md_f12_9_f4f_8 entered")
            //update UI
        }
        onExited: {
            console.log("md_f12_9_f4f_8: pending_331_b_mw_md_f12_9_f4f_8 exited")
        }
    }
    FinalState {
        id: final_eba_a_md_md
        onEntered: {
            console.log("md: final_eba_a_md_md entered")
            //update UI
        }
        onExited: {
            console.log("md: final_eba_a_md_md exited")
        }
    }
    State {
        id: selectPizza_finished_md_md_9e2_9
        SignalTransition {
            targetState: pending_e80_9_mw_md_9e2_9_a99_b
            signal: confirmButton.clicked
            guard: local.hasLock()
            onTriggered: {
                var data = mdmodel.testData()
                local.broadcastTransition("confirmPizzaSelection_md", data)
                local.release()
            }
        }
        onEntered: {
            console.log("md_9e2_9: selectPizza_finished_md_md_9e2_9 entered")
            //update UI
            confirmButton.visible = true
        }
        onExited: {
            console.log("md_9e2_9: selectPizza_finished_md_md_9e2_9 exited")
            confirmButton.visible = false
        }
    }
    State {
        id: pending_e80_9_mw_md_9e2_9_a99_b
        SignalTransition {
            targetState: pending_c9d_b_mw_md_9e2_9_a99_b
            signal: mw.defrostFinishedOccured // defrost_finished_mw
        }
        onEntered: {
            console.log("md_9e2_9_a99_b: pending_e80_9_mw_md_9e2_9_a99_b entered")
            //update UI
        }
        onExited: {
            console.log("md_9e2_9_a99_b: pending_e80_9_mw_md_9e2_9_a99_b exited")
        }
    }
    State {
        id: pending_c9d_b_mw_md_9e2_9_a99_b
        SignalTransition {
            targetState: final_eba_a_md_md
            signal: mw.cookFinishedOccured // cook_finished_mw
        }
        onEntered: {
            console.log("md_9e2_9_a99_b: pending_c9d_b_mw_md_9e2_9_a99_b entered")
            //update UI
        }
        onExited: {
            console.log("md_9e2_9_a99_b: pending_c9d_b_mw_md_9e2_9_a99_b exited")
        }
    }
    State {
        id: selectCookingMode_finished_mw_md_8ce_b
        SignalTransition {
            targetState: par_15f_b_md_8ce_b_md
            signal: mw.setpowerOccured // setPower_mw
        }
        onEntered: {
            console.log("md_8ce_b: selectCookingMode_finished_mw_md_8ce_b entered")
            //update UI
        }
        onExited: {
            console.log("md_8ce_b: selectCookingMode_finished_mw_md_8ce_b exited")
        }
    }
    State {
        id: par_15f_b_md_8ce_b_md
        childMode: QState.ParallelStates
        SignalTransition {
            targetState: final_eba_a_md_md
            signal: par_15f_b_md_8ce_b_md.finished
        }
        onEntered: {
            console.log("md_8ce_b_md: par_15f_b_md_8ce_b_md entered")
            //update UI
        }
        onExited: {
            console.log("md_8ce_b_md: par_15f_b_md_8ce_b_md exited")
        }
        State {
            id: comp_fca_a_mw_md_8ce_b_md_mw
            initialState: pending_718_9_mw_md_8ce_b_md_mw
            onEntered: {
                console.log("md_8ce_b_md_mw: comp_fca_a_mw_md_8ce_b_md_mw entered")
                //update UI
            }
            onExited: {
                console.log("md_8ce_b_md_mw: comp_fca_a_mw_md_8ce_b_md_mw exited")
            }
            State {
                id: pending_718_9_mw_md_8ce_b_md_mw
                SignalTransition {
                    targetState: final_9e5_a_mw_md_8ce_b_md_mw
                    signal: mw.showconfigFinishedOccured // showConfig_finished_mw
                }
                onEntered: {
                    console.log("md_8ce_b_md_mw: pending_718_9_mw_md_8ce_b_md_mw entered")
                    //update UI
                }
                onExited: {
                    console.log("md_8ce_b_md_mw: pending_718_9_mw_md_8ce_b_md_mw exited")
                }
            }
            FinalState {
                id: final_9e5_a_mw_md_8ce_b_md_mw
                onEntered: {
                    console.log("md_8ce_b_md_mw: final_9e5_a_mw_md_8ce_b_md_mw entered")
                    //update UI
                }
                onExited: {
                    console.log("md_8ce_b_md_mw: final_9e5_a_mw_md_8ce_b_md_mw exited")
                }
            }
        }
        State {
            id: comp_47d_9_mw_md_8ce_b_md_md
            initialState: showConfig_md_md_8ce_b_md_md
            onEntered: {
                console.log("md_8ce_b_md_md: comp_47d_9_mw_md_8ce_b_md_md entered")
                //update UI
            }
            onExited: {
                console.log("md_8ce_b_md_md: comp_47d_9_mw_md_8ce_b_md_md exited")
            }
            State {
                id: showConfig_md_md_8ce_b_md_md
                SignalTransition {
                    targetState: final_fc8_a_mw_md_8ce_b_md_md
                    signal: showconfigFinished
                    onTriggered: {
                    }
                }
                onEntered: {
                    console.log("md_8ce_b_md_md: showConfig_md_md_8ce_b_md_md entered")
                    //update UI
                    //execute hooks, i.e. actual behavior code
                    mdmodel.showConfig()
                }
                onExited: {
                    console.log("md_8ce_b_md_md: showConfig_md_md_8ce_b_md_md exited")
                }
            }
            FinalState {
                id: final_fc8_a_mw_md_8ce_b_md_md
                onEntered: {
                    console.log("md_8ce_b_md_md: final_fc8_a_mw_md_8ce_b_md_md entered")
                    //update UI
                }
                onExited: {
                    console.log("md_8ce_b_md_md: final_fc8_a_mw_md_8ce_b_md_md exited")
                }
            }
        }
    }
    function showConfig_callback(){
        showconfigFinished()
    }
    signal showconfigFinished
}
