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
    func getRecommendedWorkoutTypes() -> [ExerciseType]
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
    
    func getRecommendedWorkoutTypes() -> [ExerciseType] {
        //logic based on user's asthma condition
        return [.swimming, .running, .indoorCycling]
    }
}
