//
//  redux_archApp.swift
//  redux-arch
//
//  Created by Balogun Kayode on 05/09/2024.
//

import SwiftUI

@main
struct redux_archApp: App {
    let store =  Store(reducer: reducer)
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
