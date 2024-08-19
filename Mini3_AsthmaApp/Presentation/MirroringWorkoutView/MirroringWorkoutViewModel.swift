//
//  MirroringWorkoutViewModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import Foundation

class MirroringWorkoutViewModel: ObservableObject {
    private let workoutManager = WorkoutManager.shared
    private let exerciseUseCase: ExerciseUseCase
    
    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }
    
    @MainActor func togglePause() {
        if let session = workoutManager.session {
            workoutManager.sessionState == .running ? session.pause() : session.resume()
        }
    }
    
    @MainActor func stopWorkout() {
        workoutManager.session?.stopActivity(with: .now)
    }
    
    @MainActor func isWorkingOut() -> Bool {
        return workoutManager.sessionState.isActive
    }
    
    @MainActor func getActiveWorkout() -> ExerciseType? {
        return workoutManager.selectedWorkout?.exerciseTypeEquivalent
    }
}
