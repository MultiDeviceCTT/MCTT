import QtQuick 2.0
import QtQml.StateMachine 1.0
StateMachine {
    id: stateMachine_mw
    initialState: init_292_8_mw_mw
    //activate state machine
    running: true
    State {
        id: init_292_8_mw_mw
        SignalTransition {
            targetState: selectPizza_finished_mw_mw_a85_9
            signal: confirmButton.clicked
            guard: local.hasLock() && selectionCombo.currentText === "Pizza"
            onTriggered: {
                local.broadcastTransition("selectPizza_mw", "")
                local.release()
            }
        }
        SignalTransition {
            targetState: selectPizza_finished_md_mw_90e_9
            signal: md.selectpizzaOccured // selectPizza_md
        }
        SignalTransition {
            targetState: selectCookingMode_finished_mw_mw_335_8
            signal: confirmButton.clicked
            guard: local.hasLock() && selectionCombo.currentText === "Manual"
            onTriggered: {
                local.broadcastTransition("selectCookingMode_mw", "")
                local.release()
            }
        }
        onEntered: {
            console.log("mw: init_292_8_mw_mw entered")
            //update UI
            confirmButton.enabled = true
        }
        onExited: {
            console.log("mw: init_292_8_mw_mw exited")
            confirmButton.enabled = false
        }
    }
    State {
        id: selectPizza_finished_mw_mw_a85_9
        SignalTransition {
            targetState: defrost_mw_mw_a85_9_6cf_a
            signal: confirmButton.clicked
            guard: local.hasLock()
            onTriggered: {
                local.broadcastTransition("confirmPizzaSelection_mw", "")
                local.release()
            }
        }
        onEntered: {
            console.log("mw_a85_9: selectPizza_finished_mw_mw_a85_9 entered")
            //update UI
            confirmButton.enabled = true
        }
        onExited: {
            console.log("mw_a85_9: selectPizza_finished_mw_mw_a85_9 exited")
            confirmButton.enabled = false
        }
    }
    State {
        id: defrost_mw_mw_a85_9_6cf_a
        SignalTransition {
            targetState: cook_mw_mw_a85_9_6cf_a
            signal: defrostFinished
            onTriggered: {
            }
        }
        onEntered: {
            console.log("mw_a85_9_6cf_a: defrost_mw_mw_a85_9_6cf_a entered")
            //update UI
            //execute hooks, i.e. actual behavior code
            mwmodel.defrost()
        }
        onExited: {
            console.log("mw_a85_9_6cf_a: defrost_mw_mw_a85_9_6cf_a exited")
        }
    }
    State {
        id: cook_mw_mw_a85_9_6cf_a
        SignalTransition {
            targetState: final_3bd_b_mw_mw
            signal: cookFinished
            onTriggered: {
            }
        }
        onEntered: {
            console.log("mw_a85_9_6cf_a: cook_mw_mw_a85_9_6cf_a entered")
            //update UI
            //execute hooks, i.e. actual behavior code
            mwmodel.cook()
        }
        onExited: {
            console.log("mw_a85_9_6cf_a: cook_mw_mw_a85_9_6cf_a exited")
        }
    }
    FinalState {
        id: final_3bd_b_mw_mw
        onEntered: {
            console.log("mw: final_3bd_b_mw_mw entered")
            //update UI
        }
        onExited: {
            console.log("mw: final_3bd_b_mw_mw exited")
        }
    }
    State {
        id: selectPizza_finished_md_mw_90e_9
        SignalTransition {
            targetState: defrost_mw_mw_90e_9_432_b
            signal: md.confirmpizzaselectionOccured // confirmPizzaSelection_md
        }
        onEntered: {
            console.log("mw_90e_9: selectPizza_finished_md_mw_90e_9 entered")
            //update UI
        }
        onExited: {
            console.log("mw_90e_9: selectPizza_finished_md_mw_90e_9 exited")
        }
    }
    State {
        id: defrost_mw_mw_90e_9_432_b
        SignalTransition {
            targetState: cook_mw_mw_90e_9_432_b
            signal: defrostFinished
            onTriggered: {
            }
        }
        onEntered: {
            console.log("mw_90e_9_432_b: defrost_mw_mw_90e_9_432_b entered")
            //update UI
            //execute hooks, i.e. actual behavior code
            mwmodel.defrost()
        }
        onExited: {
            console.log("mw_90e_9_432_b: defrost_mw_mw_90e_9_432_b exited")
        }
    }
    State {
        id: cook_mw_mw_90e_9_432_b
        SignalTransition {
            targetState: final_3bd_b_mw_mw
            signal: cookFinished
            onTriggered: {
            }
        }
        onEntered: {
            console.log("mw_90e_9_432_b: cook_mw_mw_90e_9_432_b entered")
            //update UI
            //execute hooks, i.e. actual behavior code
            mwmodel.cook()
        }
        onExited: {
            console.log("mw_90e_9_432_b: cook_mw_mw_90e_9_432_b exited")
        }
    }
    State {
        id: selectCookingMode_finished_mw_mw_335_8
        SignalTransition {
            targetState: par_192_9_mw_335_8_mw
            signal: powerButton.clicked
            guard: local.hasLock()
            onTriggered: {
                local.broadcastTransition("setPower_mw", "")
                local.release()
            }
        }
        onEntered: {
            console.log("mw_335_8: selectCookingMode_finished_mw_mw_335_8 entered")
            //update UI
            powerButton.enabled = true
        }
        onExited: {
            console.log("mw_335_8: selectCookingMode_finished_mw_mw_335_8 exited")
            powerButton.enabled = false
        }
    }
    State {
        id: par_192_9_mw_335_8_mw
        childMode: QState.ParallelStates
        SignalTransition {
            targetState: final_3bd_b_mw_mw
            signal: par_192_9_mw_335_8_mw.finished
        }
        onEntered: {
            console.log("mw_335_8_mw: par_192_9_mw_335_8_mw entered")
            //update UI
        }
        onExited: {
            console.log("mw_335_8_mw: par_192_9_mw_335_8_mw exited")
        }
        State {
            id: comp_a70_a_mw_mw_335_8_mw_mw
            initialState: showConfig_mw_mw_335_8_mw_mw
            onEntered: {
                console.log("mw_335_8_mw_mw: comp_a70_a_mw_mw_335_8_mw_mw entered")
                //update UI
            }
            onExited: {
                console.log("mw_335_8_mw_mw: comp_a70_a_mw_mw_335_8_mw_mw exited")
            }
            State {
                id: showConfig_mw_mw_335_8_mw_mw
                SignalTransition {
                    targetState: final_3c8_8_mw_mw_335_8_mw_mw
                    signal: showconfigFinished
                    onTriggered: {
                    }
                }
                onEntered: {
                    console.log("mw_335_8_mw_mw: showConfig_mw_mw_335_8_mw_mw entered")
                    //update UI
                    //execute hooks, i.e. actual behavior code
                }
                onExited: {
                    console.log("mw_335_8_mw_mw: showConfig_mw_mw_335_8_mw_mw exited")
                }
            }
            FinalState {
                id: final_3c8_8_mw_mw_335_8_mw_mw
                onEntered: {
                    console.log("mw_335_8_mw_mw: final_3c8_8_mw_mw_335_8_mw_mw entered")
                    //update UI
                }
                onExited: {
                    console.log("mw_335_8_mw_mw: final_3c8_8_mw_mw_335_8_mw_mw exited")
                }
            }
        }
        State {
            id: comp_063_8_mw_mw_335_8_mw_md
            initialState: pending_78a_9_md_mw_335_8_mw_md
            onEntered: {
                console.log("mw_335_8_mw_md: comp_063_8_mw_mw_335_8_mw_md entered")
                //update UI
            }
            onExited: {
                console.log("mw_335_8_mw_md: comp_063_8_mw_mw_335_8_mw_md exited")
            }
            State {
                id: pending_78a_9_md_mw_335_8_mw_md
                SignalTransition {
                    targetState: final_97c_b_mw_mw_335_8_mw_md
                    signal: md.showconfigFinishedOccured // showConfig_finished_md
                }
                onEntered: {
                    console.log("mw_335_8_mw_md: pending_78a_9_md_mw_335_8_mw_md entered")
                    //update UI
                }
                onExited: {
                    console.log("mw_335_8_mw_md: pending_78a_9_md_mw_335_8_mw_md exited")
                }
            }
            FinalState {
                id: final_97c_b_mw_mw_335_8_mw_md
                onEntered: {
                    console.log("mw_335_8_mw_md: final_97c_b_mw_mw_335_8_mw_md entered")
                    //update UI
                }
                onExited: {
                    console.log("mw_335_8_mw_md: final_97c_b_mw_mw_335_8_mw_md exited")
                }
            }
        }
    }
    function defrost_callback(){
        defrostFinished()
    }
    function cook_callback(){
        cookFinished()
    }
    function showConfig_callback(){
        showconfigFinished()
    }
    signal defrostFinished
    signal cookFinished
    signal showconfigFinished
}
