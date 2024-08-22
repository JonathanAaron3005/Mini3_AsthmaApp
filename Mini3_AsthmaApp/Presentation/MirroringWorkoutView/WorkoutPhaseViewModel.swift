//
//  MirroringWorkoutViewModel.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import Foundation

class WorkoutPhaseViewModel: ObservableObject {
    let workoutManager = WorkoutManager.shared
    private let exerciseUseCase: ExerciseUseCase
    
    @Published var selectedPhase: WorkoutPhase = .warmup {
        @MainActor didSet {
            workoutManager.currentPhase = selectedPhase
        }
    }
    
    init(exerciseUseCase: ExerciseUseCase) {
        self.exerciseUseCase = exerciseUseCase
    }
    
    @MainActor func startNextPhase() {
        switch selectedPhase {
        case .warmup:
            selectedPhase = selectedPhase.nextPhase
            Task {
                do {
                    try await workoutManager.startWatchWorkout(workoutType: workoutManager.selectedWorkout ?? .swimming)
                } catch {
                    throw(error)
                }
            }
        case .workout:
            selectedPhase = selectedPhase.nextPhase
            Task {
                do {
                    try await workoutManager.startWatchCoolDown()
                } catch {
                    throw(error)
                }
            }
        case .cooldown:
            stopWorkout()
        }
    }
    
    @MainActor func togglePause() {
        if let session = workoutManager.session {
            workoutManager.session?.state == .running ? session.pause() : session.resume()
        }
    }
    
    @MainActor func stopWorkout() {
        workoutManager.session?.stopActivity(with: .now)
    }
    
    @MainActor func isWorkingOut() -> Bool {
        // if there's discrepancy between sessionState and session.state, then it'll default to false.
        return workoutManager.session?.state == .running && workoutManager.sessionState == .running
    }
    
    @MainActor func getActiveWorkout() -> ExerciseType? {
        return workoutManager.selectedWorkout?.exerciseTypeEquivalent
    }
}
