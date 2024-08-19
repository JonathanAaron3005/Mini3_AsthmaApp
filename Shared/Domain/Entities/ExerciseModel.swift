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
    case outdoorCycling
    case indoorCycling
    
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
        case .outdoorCycling:
            return .cycling
        case .indoorCycling:
            return .cycling
        }
    }
    
    var imageResource: String {
        switch self {
        case .swimming:
            return "Swimming"
        case .running:
            return "Jogging"
        case .walking:
            return "Walking"
        case .indoorCycling:
            return "Indoor_Cycling"
        case .outdoorCycling:
            return "Outdoor_Cycling"
        }
    }
    
    var description: String {
        switch self{
        case .swimming:
            return "Low risk, low intensity"
        case .running:
            return "High risk, medium intensity"
        case .walking:
            return "Low risk, low intensity"
        case .indoorCycling:
            return "Medium risk, mixed intensity"
        case .outdoorCycling:
            return "Medium risk, mixed intensity"
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
