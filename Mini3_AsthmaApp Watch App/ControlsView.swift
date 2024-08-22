//
//  ControlsView.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import os
import SwiftUI
import HealthKit

struct ControlsView: View {
    private var workoutManager = WorkoutManager.shared
    
    var body: some View {
        VStack {
            Button {
                workoutManager.session?.state == .running ? workoutManager.session?.pause() : workoutManager.session?.resume()
            } label: {
                let title = workoutManager.session?.state == .running ? "Pause" : "Resume"
                let systemImage = workoutManager.session?.state == .running ? "pause" : "play"
                HStack{
                    Image(systemName: systemImage)
                    Text(title)
                }
            }
            .disabled(!workoutManager.sessionState.isActive)
            .tint(.blue)
            
            Button {
                switch workoutManager.currentPhase {
                case .warmup:
                    Task {
                        do {
                            workoutManager.session?.stopActivity(with: .now)
                            let configuration = HKWorkoutConfiguration()
                            configuration.activityType = workoutManager.selectedWorkout ?? .swimming
                            configuration.locationType = .outdoor
                            try await workoutManager.startWorkout(workoutConfiguration: configuration)
                        } catch {
                            Logger.shared.log("Failed started workout")
                        }
                    }
                case .workout:
                    Task {
                        do {
                            workoutManager.session?.stopActivity(with: .now)
                            let configuration = HKWorkoutConfiguration()
                            configuration.activityType = .cooldown
                            configuration.locationType = .outdoor
                            try await workoutManager.startWorkout(workoutConfiguration: configuration)
                        } catch {
                            Logger.shared.log("Failed started cooldown")
                        }
                    }
                case .cooldown:
                    workoutManager.session?.stopActivity(with: .now)
                }
            } label: {
                Text("End")
            }
            .tint(.red)
            .disabled(!workoutManager.sessionState.isActive)
        }
    }
}

