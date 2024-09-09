//
//  ContentView.swift
//  redux-arch
//
//  Created by Balogun Kayode on 05/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var store: Store<AppState>
    
    private var props: Props {
        map(state: store.state.counterState)
    }
    
    var body: some View {
        VStack {
            Text("\(props.counter)")
                .padding()
            
            Button("Increment") {
                props.onIncrement()
            }.padding()
            
            Button("Decrement") {
                props.onDecrement()
            }.padding()
            
            Button("Add") {
                props.onAdd(100)
            }.padding()
            
            Spacer()
            
            Button("Add Task") {
                isPresented =  true
            }
            Spacer()

        }.sheet(isPresented: $isPresented, content: {
           AddTaskView()
        })
    }
    
    private struct Props {
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAdd: (Int) -> Void
    }
    
    
    private func map(state: CounterState) -> Props {
        Props(counter: state.counter,
            onIncrement: {
                store.dispatch(action: IncrementAction())
            },
            onDecrement: {
                store.dispatch(action: DecrementAction())
        }, onAdd: {
            store.dispatch(action: AddAction(value: $0))
        }
        )
    }
}

#Preview {
    ContentView()
}
