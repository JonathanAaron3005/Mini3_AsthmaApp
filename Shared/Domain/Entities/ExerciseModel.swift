//
//  ExerciseModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import HealthKit

internal struct ExerciseModel: Identifiable {
    let id: String
    let type: ExerciseType
    let isHavingSymptoms: Bool
    let symptomsLevel: Int
}

enum ExerciseType: String, Codable, Identifiable{
    case swimming
    case running
    case walking
    case cycling
    
    var id: String {
        self.rawValue
    }
    
    var healthKitEquivalent: HKWorkoutActivityType {
        switch self {
        case .swimming:
            return .swimming
        case .running:
            return .running
        case .walking:
            return .walking
        case .cycling:
            return .cycling
        }
    }
}
extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        case .swimming:
            return "Swimming"
        default:
            return ""
        }
    }
}
