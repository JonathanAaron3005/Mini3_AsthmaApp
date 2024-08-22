//
//  UserLocalEntity.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData

@Model
class UserLocalEntity {
    @Attribute(.unique) var id: String
    var age: Int
    var HRmax: Double
    var isUsingInhaler: Bool
    var severityLevel: SeverityLevel?
    var asthmaControl: ACTScore?
    
    init(id: String, age: Int, HRmax: Double, isUsingInhaler: Bool, severityLevel: SeverityLevel?, asthmaControl: ACTScore?) {
        self.id = id
        self.age = age
        self.HRmax = HRmax
        self.isUsingInhaler = isUsingInhaler
        self.severityLevel = severityLevel
        self.asthmaControl = asthmaControl
    }
    
    func toDomain() -> UserModel {
        return .init(
            id: self.id,
            age: self.age,
            HRmax: self.HRmax,
            isUsingInhaler: self.isUsingInhaler,
            severityLevel: self.severityLevel,
            asthmaControl: self.asthmaControl
        )
    }
}
