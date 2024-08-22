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
    
    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }
    
    @MainActor func setSelectedExercise(exerciseType: HKWorkoutActivityType){
        workoutManager.selectedWorkout = exerciseType
    }
    
    func getWorkoutTypes() -> [ExerciseType] {
        return [.swimming, .running, .cycling, .walking]
    }
    
    func startWorkout() {
        Task {
            do {
                try await workoutManager.startWatchWorkout(workoutType: .cycling)
            } catch {
                Logger.shared.log("Failed to start cycling on the paired watch.")
            }
        }
        print("workout started")
    }
    
    @MainActor func stopWorkout() {
        workoutManager.session?.stopActivity(with: .now)
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
