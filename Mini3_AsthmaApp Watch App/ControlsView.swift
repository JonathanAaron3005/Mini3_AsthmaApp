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
    @State private var showIndicatorIphone = false
    
    var body: some View {
        VStack {
            if showIndicatorIphone {
                IndicatorIphone()
            } else {
                VStack(spacing: 20) {
                    Button {
                        workoutManager.session?.state == .running ? workoutManager.session?.pause() : workoutManager.session?.resume()
                    } label: {
                        let title = workoutManager.sessionState == .running ? "Pause" : "Resume"
                        let systemImage = workoutManager.sessionState == .running ? "pause.circle.fill" : "play.circle.fill"
                        VStack {
                            Image(systemName: systemImage)
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundColor(.white)
                            Text(title)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
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
                            showIndicatorIphone = true
                        }
                    } label: {
                        VStack {
                            Image(systemName: "flag.checkered.circle.fill") // Finish flag icon
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundColor(Color(hex: "#CEF74A"))
                            Text("Finish")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#CEF74A"))
                        }
                    }
                    .padding([.top, .bottom], 4 )
                    .buttonStyle(.plain)
                    .tint(.red)
                    .disabled(!workoutManager.sessionState.isActive)
                }
                .padding()
                .padding([.top, .bottom], 10)
            }
        }
    }
}
