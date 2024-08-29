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
    
    
    private let exerciseUseCase: ExerciseUseCase
    private let userUseCase: UserUseCase
    
    @Published var selectedWorkout: ExerciseType?
    @Published var errorMessage: String?
    @Published var workoutDuration = 1800 {
        @MainActor didSet {
            workoutManager.workoutDuration = workoutDuration
        }
    }
    
    init(exerciseUseCase: ExerciseUseCase, userUseCase: UserUseCase) {
        self.exerciseUseCase = exerciseUseCase
        self.userUseCase = userUseCase
    }
    
    @MainActor func setSelectedExercise(exerciseType: ExerciseType){
        selectedWorkout = exerciseType
        workoutManager.selectedWorkout = exerciseType.healthKitEquivalent
    }
    
    func getWorkoutTypes() -> [ExerciseType] {
        return exerciseUseCase.getWorkoutTypes()
    }
    
    func getRecommendedWorkoutTypes() -> [ExerciseType] {
        let user = userUseCase.getUser()
        print(user)
        return exerciseUseCase.getRecommendedWorkoutTypes(for: user)
    }
    
    func startWarmup() {
        Task {
            do {
                try await workoutManager.startWatchWarmup()
            } catch {
                Logger.shared.log("Failed to start cycling on the paired watch.")
            }
        }
    }
    
    @MainActor func isWorkingOut() -> Bool {
        return workoutManager.sessionState.isActive
    }
    
    @MainActor func retrieveRemoteSession() {
        workoutManager.retrieveRemoteSession()
    }
    
    let workoutManager = WorkoutManager.shared
    
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
