//
//  DefaultExerciseUseCase.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation

internal protocol ExerciseUseCase {
    func saveExercise(exercise: ExerciseModel)
    func getWorkoutTypes() -> [ExerciseType]
    func getRecommendedWorkoutTypes(for user: UserModel) -> [ExerciseType]
    func getRecommendedWorkoutTypesBasedOnSeverity(_ severity: SeverityLevel) -> [ExerciseType]
    func getRecommendedWorkoutTypesBasedOnACTScore(_ actScore: ACTScore) -> [ExerciseType]
}

internal final class DefaultExerciseUseCase: ExerciseUseCase {
    private var exerciseRepo: ExerciseRepository
    
    init(exerciseRepo: ExerciseRepository) {
        self.exerciseRepo = exerciseRepo
    }
    
    func saveExercise(exercise: ExerciseModel) {
        exerciseRepo.save(exercise: exercise)
    }
    
    func getWorkoutTypes() -> [ExerciseType] {
        return [.swimming, .running, .indoorCycling, .outdoorCycling, .walking]
    }
    
    func getRecommendedWorkoutTypes(for user: UserModel) -> [ExerciseType] {
        if let severity = user.severityLevel {
            return getRecommendedWorkoutTypesBasedOnSeverity(severity)
        } else if let actScore = user.asthmaControl {
            return getRecommendedWorkoutTypesBasedOnACTScore(actScore)
        } else {
            return [.swimming, .walking]
        }
    }
    
    internal func getRecommendedWorkoutTypesBasedOnSeverity(_ severity: SeverityLevel) -> [ExerciseType] {
        switch severity {
        case .intermittent:
            return [.swimming, .running, .indoorCycling, .walking]
        case .mild:
            return [.swimming, .indoorCycling, .walking]
        case .moderate:
            return [.swimming, .indoorCycling]
        case .severe:
            return [.swimming, .walking]
        }
    }
    
    internal func getRecommendedWorkoutTypesBasedOnACTScore(_ actScore: ACTScore) -> [ExerciseType] {
        switch actScore {
        case .wellControlled:
            return [.swimming, .running, .indoorCycling, .walking]
        case .poorlyControlled:
            return [.swimming, .indoorCycling, .walking]
        case .veryPoorlyControlled:
            return [.swimming, .walking]
        }
    }
}

