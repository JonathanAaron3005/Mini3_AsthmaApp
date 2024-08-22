//
//  MetricsView.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    @ObservedObject private var workoutManager = WorkoutManager.shared
    @State private var showAlert = false
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.session?.startDate ?? Date(),
                                             isPaused: workoutManager.sessionState == .paused)) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(elapsedTime: elapsedTime(with: context.date), workoutDuration: TimeInterval(workoutManager.currentPhase == .workout ? workoutManager.workoutDuration : workoutManager.currentPhase.duration), showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                Text(workoutManager.session?.currentActivity.workoutConfiguration.activityType.name ?? "Unknown Phase")
                
                if workoutManager.isAboveHRMax {
                    Text("⚠️ High Heart Rate!")
                        .foregroundColor(.red)
                        .onAppear {
                            showAlert = true
                        }
                }
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            .padding([.top], 30)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("High Heart Rate Alert"),
                    message: Text("Your heart rate is above the maximum limit. Please slow down or take a break."),
                    dismissButton: .default(Text("OK")) {
                        showAlert = false
                    }
                )
            }
        }
    }
    
    @MainActor func elapsedTime(with contextDate: Date) -> TimeInterval {
        return workoutManager.builder?.elapsedTime(at: contextDate) ?? 0
    }
}
