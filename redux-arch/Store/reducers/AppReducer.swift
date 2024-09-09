//
//  AppReducer.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation


func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.counterState = counterReducer(state.counterState, action)
    state.taskState =  taskReducer(state.taskState, action)
    return state
}
