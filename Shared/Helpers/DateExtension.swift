//
//  DateExtension.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 17/08/24.
//

import Foundation

extension Date {
    func age() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year ?? 0
    }
    
    func stringFormat() -> String {
        let encoder = DateFormatter()
        encoder.dateStyle = .long
        return encoder.string(from: self)
    }
}

