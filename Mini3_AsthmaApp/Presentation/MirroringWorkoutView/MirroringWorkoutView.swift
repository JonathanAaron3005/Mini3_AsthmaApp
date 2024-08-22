//
//  MirroringWorkoutView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI
import HealthKit

struct MirroringWorkoutView: View {
    @ObservedObject var viewModel: WorkoutPhaseViewModel
    @State var toggleButtonText : String = "Pause warm-up"
    @State var toggleButtonIcon : String = "pause.fill"
    @State var toggleButtonColor : Color = .yellow.opacity(0.4)
    
    var body: some View {
        ZStack {
            ScrollView {
                NavigationStack {
                    let fromDate = viewModel.workoutManager.session?.startDate ?? Date()
                    let schedule = MetricsTimelineSchedule(from: fromDate, isPaused: viewModel.workoutManager.sessionState == .paused)
                    let isWorkoutPhase = viewModel.workoutManager.currentPhase == .workout
                    
                    TimelineView(schedule) { context in
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Image(systemName: viewModel.selectedPhase == .workout
                                      ? viewModel.workoutManager.selectedWorkout?.exerciseTypeEquivalent?.icon ?? ""
                                      : viewModel.selectedPhase.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                
                                Text(viewModel.selectedPhase.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(viewModel.selectedPhase.description)
                                    .font(.body)
                            }
                            .padding()
                            
                            metricsView(viewModel: viewModel)
                            
                            ElapsedTimeView(elapsedTime: workoutTimeInterval(context.date), workoutDuration: isWorkoutPhase ?  TimeInterval(viewModel.workoutManager.workoutDuration) : TimeInterval(viewModel.workoutManager.currentPhase.duration), showSubseconds: context.cadence == .live)
                                .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                           
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 0.7)
                                .opacity(0.6)
                                .padding()
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.workoutManager.session?.currentActivity.workoutConfiguration.activityType.name ?? "Unknown Phase")
                                Text(viewModel.selectedPhase.aboutTitle)
                                    .foregroundStyle(.gray.opacity(0.8))
                                    .padding(.bottom, 5)
                                Text(viewModel.selectedPhase.aboutDescription)
                                    .font(.body)
                                    .padding(.bottom, 200)
                            }
                            .padding()
                            
                        }
                        .padding()
                    }
                }
            }
            
            NavigationStack {
                Spacer()
                
                VStack {
                    Button {
                        if let session = viewModel.workoutManager.session {
                            if viewModel.isWorkingOut() {
                                session.pause()
                                viewModel.workoutManager.sessionState = .paused
                                toggleButtonText = "Resume \(viewModel.selectedPhase.pauseBtnText)"
                                toggleButtonIcon = "play.fill"
                                toggleButtonColor = .green.opacity(0.4)
                            } else {
                                session.resume()
                                viewModel.workoutManager.sessionState = .running
                                toggleButtonText = "Pause \(viewModel.selectedPhase.pauseBtnText)"
                                toggleButtonIcon = "pause.fill"
                                toggleButtonColor = .yellow.opacity(0.4)
                            }
                        }
                    } label: {
                        HStack {
                            CustomButton(text: toggleButtonText, color: toggleButtonColor, image: toggleButtonIcon)
                                .padding(.top, 17)
                        }
                    }
                    
                    
                    Button {
                        viewModel.startNextPhase()
                    } label: {
                        HStack {
                            CustomButton(text: "End \(viewModel.selectedPhase.endBtnText)", color: .black.opacity(0.88), image: "stop.fill")
                        }
                    }
                    
                    Button {
                        viewModel.workoutManager.session?.stopActivity(with: .now )
                    } label: {
                        NavigationLink {
                            HomeView()
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                        } label: {
                            Text("I need to cancel this exercise")
                                .foregroundStyle(.black.opacity(0.6))
                                .padding(.top, 15)
                                .padding(.bottom, 20)
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    }
                }
                .padding()
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                        .ignoresSafeArea()
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .padding(.top, 30)
    }
}

extension MirroringWorkoutView {
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
    @MainActor private func metricsView(viewModel: WorkoutPhaseViewModel) -> some View {
        let heartRate = viewModel.workoutManager.heartRate
        let backgroundColor = heartRateBackgroundColor(heartRate: heartRate)
        let message = heartRateMessage(heartRate: heartRate)
        
        Group {
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(height: 70)
                .overlay(
                    HStack{
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        VStack(alignment: .leading, spacing: -5){
                            Text("\(Int(heartRate))")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("beats per minute")
                        }
                        Spacer()
                        Text(message)
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                        .padding()
                        .foregroundStyle(backgroundColor == .red ? .white : .black)
                )
                .padding()
        }
    }
    
    private func heartRateBackgroundColor(heartRate: Double) -> Color {
        switch heartRate {
        case ..<100:
            return .white
        case 100..<140:
            return .yellow
        case 140...:
            return .red
        default:
            return .white
        }
    }
    
    private func heartRateMessage(heartRate: Double) -> String {
        switch heartRate {
        case ..<100:
            return "All good!"
        case 100..<140:
            return "Exercise caution"
        case 140...:
            return "Wind down, now!"
        default:
            return "All good!"
        }
    }
    
    
    @ViewBuilder
    @MainActor private func footerView(viewModel: WorkoutPhaseViewModel) -> some View {
        VStack {
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
