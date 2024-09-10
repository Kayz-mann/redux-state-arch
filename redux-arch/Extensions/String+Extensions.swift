//
//  String+Extensions.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation

extension String {
    func urlEncode() -> String {
        self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
    
    func toInt() -> Int {
        let ratingDouble =  Double(self) ?? 0.0
        return Int(ratingDouble.rounded())
    }
}
