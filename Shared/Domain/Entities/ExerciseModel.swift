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
    
    var title: String {
        switch self{
        case .swimming:
            return "Swimming"
        case .running:
            return "Running"
        case .walking:
            return "Walking"
        case .indoorCycling:
            return "Indoor Cycling"
        case .outdoorCycling:
            return "Outdoor Cycling"
        }
    }
    
    var icon: String {
        switch self{
        case .swimming:
            return "figure.pool.swim"
        case .running:
            return "figure.run"
        case .walking:
            return "figure.walk"
        case .indoorCycling:
            return "figure.outdoor.cycle"
        case .outdoorCycling:
            return "figure.indoor.cycle"
        }
    }
    
    var iconColor: String {
        switch self{
        case .swimming:
            return "BreatheeeTeal"
        case .running:
            return "BreatheeeYellow"
        case .walking:
            return "BreatheeePurple"
        case .indoorCycling:
            return "BreatheeeCoral"
        case .outdoorCycling:
            return "BreatheeeRed"
        }
    }
    
    var disclaimer: String {
        switch self{
        case .swimming:
            return "Swimming comes with risk. For example, excess chlorine in the water may irritate your airways, thus triggering an asthma. We’ll be with you. Always exercise caution. Get out off the water, in the chance of asthma symptoms."
        case .running:
            return ""
        case .walking:
            return ""
        case .indoorCycling:
            return ""
        case .outdoorCycling:
            return ""
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
    
    var exerciseTypeEquivalent: ExerciseType? {
        switch self {
        case .swimming:
            return .swimming
        case .running:
            return .running
        case .walking:
            return .walking
        case .cycling:
            return .outdoorCycling // Anda dapat memutuskan apakah ini indoor atau outdoor
        default:
            return nil
        }
    }
}

enum WorkoutPhase {
    case warmup
    case workout
    case cooldown
    
    var duration: Int {
        switch self {
        case .warmup, .cooldown: return 5
        case .workout: return 30
        }
    }
    
    var nextPhase: WorkoutPhase {
        switch self {
        case .warmup: return .workout
        case .workout: return .cooldown
        case .cooldown: return .cooldown
        }
    }

    var title: String {
        switch self {
        case .warmup: return "Warmin' up"
        case .workout: return "Exercise"
        case .cooldown: return "Cool Down"
        }
    }
    
    var aboutTitle: String {
        switch self {
        case .warmup: return "ABOUT WARMING UP"
        case .workout: return "SAFETY IN EXERCISING"
        case .cooldown: return "ABOUT COOLING DOWN"
        }
    }
    
    var aboutDescription: String {
        switch self {
        case .warmup: return "A good warm-up, according to American Heart Association, may widen your blood vessels. This ensures that your muscles are going to have an adequate supply of oxygen while you’re working out!"
        case .workout: return "When you have an asthma, or are recovering from an illness, your body are more fragile than it should’ve been. Adding exercise into the mix will put an extra strain on your body."
        case .cooldown: return "Doing proper cool-down is as important as warming up. The American Heart Association caution against stopping an exercise briefly, because it may cause a light-headedness."
        }
    }
    
    var description: String {
        switch self {
        case .warmup: return "Let's get those muscles ready!"
        case .workout: return "We're helping you to keep an eye out for any symptoms."
        case .cooldown: return "You did amazing! Let's end this slowly."
        }
    }
    
    var step: Int {
        switch self {
        case .warmup: return 1
        case .workout: return 2
        case .cooldown: return 3
        }
    }
    
    var icon: String {
        switch self {
        case .warmup: return "figure.cooldown"
        case .workout: return ""
        case .cooldown: return "figure.strengthtraining.functional"
        }
    }
    
    var pauseBtnText: String {
        switch self {
        case .warmup: return "warm-up"
        case .workout: return "exercise"
        case .cooldown: return "cool-down"
        }
    }
    
    var endBtnText: String {
        switch self {
        case .warmup: return "warming up"
        case .workout: return "exercising"
        case .cooldown: return "cooling down"
        }
    }
}
