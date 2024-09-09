//
//  LogMiddleware.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation

func logMiddleWare() -> MiddleWare<AppState> {
    return {state, action, dispatch in
        print("LOG MIDDLEWARE")
    }
}
