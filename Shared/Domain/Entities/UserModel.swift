//
//  UserModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData

internal struct UserModel: Identifiable {
    let id: String
    var age: Int
    var HRmax: Double
    var isUsingInhaler: Bool
    var severityLevel: SeverityLevel?
    var asthmaControl: ACTScore?
}

enum SeverityLevel: String, Codable {
    case intermittent
    case mild
    case moderate
    case severe
}

enum ACTScore: String, Codable {
    case veryPoorlyControlled
    case poorlyControlled
    case wellControlled
}
