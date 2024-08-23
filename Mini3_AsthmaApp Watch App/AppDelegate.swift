//
//  AppDelegate.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import os
import WatchKit
import HealthKit
import SwiftUI

class AppDelegate: NSObject, WKApplicationDelegate {

    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        Task {
            do {
                AppConfig.isStartedFromPhone = true
                WorkoutManager.shared.resetWorkout()
                try await WorkoutManager.shared.startWorkout(workoutConfiguration: workoutConfiguration)
                Logger.shared.log("Successfully started workout")

                // Notify MetricsView to show warm-up alert
                DispatchQueue.main.async {
                    // Assuming you have a way to update MetricsView from AppDelegate, like a shared state or notification
                    NotificationCenter.default.post(name: .workoutStartedFromPhone, object: nil)
                }
                
            } catch {
                Logger.shared.log("Failed started workout")
            }
        }
    }
}
