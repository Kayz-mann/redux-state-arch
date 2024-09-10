//
//  View+Extensions.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView {self}
    }
}
