//
//  HomeViewModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import os
import HealthKitUI
import HealthKit
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    let workoutManager = WorkoutManager.shared
    private let exerciseUseCase: ExerciseUseCase
    
    @Published var selectedWorkout: ExerciseType?
    @Published var errorMessage: String?
    @Published var workoutDuration = 30 {
        @MainActor didSet {
            workoutManager.workoutDuration = workoutDuration
        }
    }
    
    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }
    
    @MainActor func setSelectedExercise(exerciseType: ExerciseType){
        selectedWorkout = exerciseType
        workoutManager.selectedWorkout = exerciseType.healthKitEquivalent
    }
    
    func getWorkoutTypes() -> [ExerciseType] {
        return exerciseUseCase.getWorkoutTypes()
    }
    
    func getRecommendedWorkoutTypes() -> [ExerciseType] {
        return exerciseUseCase.getRecommendedWorkoutTypes()
    }
    
    func startWorkout(exerciseType: ExerciseType) {
        Task {
            do {
                try await workoutManager.startWatchWorkout(workoutType: exerciseType.healthKitEquivalent)
            } catch {
                Logger.shared.log("Failed to start cycling on the paired watch.")
            }
        }
        print("workout started")
    }
    
    @MainActor func isWorkingOut() -> Bool {
        return workoutManager.sessionState.isActive
    }
    
    @MainActor func retrieveRemoteSession() {
        workoutManager.retrieveRemoteSession()
    }
    
    func getHealthStore() -> HKHealthStore {
        return workoutManager.healthStore
    }
    
    func getTypesToShare() -> Set<HKSampleType> {
        return workoutManager.typesToShare
    }
    
    func getTypesToRead() -> Set<HKObjectType> {
        return workoutManager.typesToRead
    }
}
