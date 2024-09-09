//
//  Store.swift
//  redux-arch
//
//  Created by Balogun Kayode on 05/09/2024.
//

import Foundation
import Combine

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias MiddleWare<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) ->  Void

protocol ReduxState {}

struct AppState: ReduxState {
    var counterState =  CounterState()
    var taskState =  TaskState()
}

struct TaskState: ReduxState {
    var tasks: [Task] = [Task]()
}

struct CounterState: ReduxState {
    var counter = 0
}

protocol Action {}

struct IncrementAction: Action {}
struct DecrementAction: Action {}
struct IncrementActionAsync: Action {}


struct AddTaskAction: Action {
    let task: Task
}

struct AddAction: Action {
    let value: Int
}

class Store<StoreState: ReduxState> : ObservableObject {
    private let reducer: Reducer<StoreState>
    @Published var state: StoreState
    var middlewares: [MiddleWare<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [MiddleWare<StoreState>]) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        //run all middlewares
        middlewares.forEach{middleware in
            middleware(state, action, dispatch)
        }
    }
}
