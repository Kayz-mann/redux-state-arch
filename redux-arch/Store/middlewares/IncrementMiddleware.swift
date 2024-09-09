//
//  IncrementMiddleware.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation


func IncrementMiddleware() -> MiddleWare<AppState> {
    return { state, action, dispatch in
        
        switch action {
        case _ as IncrementActionAsync:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                dispatch(IncrementAction())
            }
        default:
            break
        }
    }
}
