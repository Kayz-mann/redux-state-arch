//
//  AddTaskView.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import SwiftUI

struct AddTaskView: View {
    @State private var name: String =  ""
    @EnvironmentObject var store: Store<AppState>
    
    struct Props {
        //dispatch
        let onTaskAdded: (Task) -> ()
        
        //get tasks
        let tasks: [Task]
        
    }
    
    private func map(state: TaskState) -> Props {
        return Props(onTaskAdded: {task in
            store.dispatch(action: AddTaskAction(task: task))
        }, tasks: state.tasks)
    }
    
    var body: some View {
        let props = map(state: store.state.taskState)
        VStack {
            TextField("Enter Task", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Add") {
                let task =  Task(title: name)
                props.onTaskAdded(task)
            }
            
            List(props.tasks, id: \.id) {
                task in
                Text(task.title)
            }
            
            Spacer()
        }.padding()
    }
}

#Preview {
    AddTaskView()
}
