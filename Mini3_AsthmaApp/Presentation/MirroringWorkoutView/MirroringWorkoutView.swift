//
//  MirroringWorkoutView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import os
import SwiftUI
import HealthKit

struct MirroringWorkoutView: View {
    @StateObject private var viewModel = MirroringWorkoutViewModel(exerciseUseCase: DefaultExerciseUseCase(exerciseRepo: LocalExerciseRepository()))

    var body: some View {
        NavigationStack {
            let fromDate = viewModel.workoutManager.session?.startDate ?? Date()
            let schedule = MetricsTimelineSchedule(from: fromDate, isPaused: viewModel.workoutManager.sessionState == .paused)
            TimelineView(schedule) { context in
                List {
                    Section {
                        metricsView()
                    } header: {
                        headerView(context: context)
                    } footer: {
                        footerView()
                    }
                }
            }
            .navigationBarTitle("Mirroring Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension MirroringWorkoutView {
    @ViewBuilder
    @MainActor private func headerView(context: TimelineViewDefaultContext) -> some View {
        VStack {
            Spacer(minLength: 30)
            LabeledContent {
                ElapsedTimeView(elapsedTime: workoutTimeInterval(context.date), showSubseconds: context.cadence == .live)
                    .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            } label: {
                Text("Elapsed")
            }
            .foregroundColor(.yellow)
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            Spacer(minLength: 15)
        }
    }
    
    @MainActor private func workoutTimeInterval(_ contextDate: Date) -> TimeInterval {
        var timeInterval = viewModel.workoutManager.elapsedTimeInterval
        if viewModel.workoutManager.sessionState == .running {
            if let referenceContextDate = viewModel.workoutManager.contextDate {
                timeInterval += (contextDate.timeIntervalSinceReferenceDate - referenceContextDate.timeIntervalSinceReferenceDate)
            } else {
                viewModel.workoutManager.contextDate = contextDate
            }
        } else {
            var date = contextDate
            date.addTimeInterval(viewModel.workoutManager.elapsedTimeInterval)
            timeInterval = date.timeIntervalSinceReferenceDate - contextDate.timeIntervalSinceReferenceDate
            viewModel.workoutManager.contextDate = nil
        }
        return timeInterval
    }
    
    @ViewBuilder
    @MainActor private func metricsView() -> some View {
        Group {
            LabeledContent("Heart Rate", value: viewModel.workoutManager.heartRate, format: .number.precision(.fractionLength(0)))
        }
        .font(.system(.title2, design: .rounded).monospacedDigit().lowercaseSmallCaps())
    }
    
    @ViewBuilder
    @MainActor private func footerView() -> some View {
        VStack {
            Spacer(minLength: 40)
            HStack {
                Button {
                    if let session = viewModel.workoutManager.session {
                        viewModel.workoutManager.sessionState == .running ? session.pause() : session.resume()
                    }
                } label: {
                    let title = viewModel.workoutManager.sessionState == .running ? "Pause" : "Resume"
                    let systemImage = viewModel.workoutManager.sessionState == .running ? "pause" : "play"
                    Text(title)
                }
                .disabled(!viewModel.workoutManager.sessionState.isActive)

                Button {
                    viewModel.workoutManager.session?.stopActivity(with: .now )
                } label: {
                    Text("End")
                }
                .tint(.green)
                .disabled(!viewModel.workoutManager.sessionState.isActive)

                Spacer()
            }
            .buttonStyle(.bordered)
        }
    }
}
