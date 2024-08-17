//
//  DefaultExerciseUseCase.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation

internal protocol ExerciseUseCase {
    func saveExercise(exercise: ExerciseModel)
}

internal final class DefaultExerciseUseCase: ExerciseUseCase {
    
    private var exerciseRepo: ExerciseRepository
    
    init(exerciseRepo: ExerciseRepository) {
        self.exerciseRepo = exerciseRepo
    }
    
    func saveExercise(exercise: ExerciseModel) {
        exerciseRepo.save(exercise: exercise)
    }
}
