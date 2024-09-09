//
//  redux_archApp.swift
//  redux-arch
//
//  Created by Balogun Kayode on 05/09/2024.
//

import SwiftUI

@main
struct redux_archApp: App {
    let store =  Store<AppState>(reducer: appReducer, state: AppState(), middlewares: [logMiddleWare()])
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
