//
//  TaskReducer.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation


func taskReducer(_ state: TaskState, _ action: Action) -> TaskState {
    var state =  state
    
    switch action {
        case let action as AddTaskAction:
            state.tasks.append(action.task)
        default:
            break
    }
    
    return state
}
