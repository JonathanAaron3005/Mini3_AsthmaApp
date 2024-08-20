//
//  MetricsView.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    private var workoutManager = WorkoutManager.shared
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.session?.startDate ?? Date(),
                                             isPaused: workoutManager.sessionState == .paused)) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(elapsedTime: elapsedTime(with: context.date), showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            .padding([.top], 30)
        }
    }
    
    @MainActor func elapsedTime(with contextDate: Date) -> TimeInterval {
        return workoutManager.builder?.elapsedTime(at: contextDate) ?? 0
    }
}
