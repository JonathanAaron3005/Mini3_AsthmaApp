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
    
    private let workoutManager = WorkoutManager.shared
    private let exerciseUseCase: ExerciseUseCase
    
    @Published var selectedWorkout: ExerciseType?
    @Published var workoutDuration: Int = 30
    
    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }
    
    @MainActor func setSelectedExercise(exerciseType: ExerciseType){
        selectedWorkout = exerciseType
        workoutManager.selectedWorkout = exerciseType.healthKitEquivalent
    }
    
    func getWorkoutTypes() -> [ExerciseType] {
        return [.swimming, .running, .indoorCycling, .outdoorCycling, .walking]
    }
    
    func getRecommendedWorkoutTypes() -> [ExerciseType] {
        return [.swimming, .running, .indoorCycling]
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
