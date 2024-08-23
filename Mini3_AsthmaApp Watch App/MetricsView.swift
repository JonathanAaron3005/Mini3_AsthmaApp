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
    
    @State private var showWarmUpAlert = false // Display WarmUpTimer initially
    
    @State private var startTimer = false // Determine when to start the exercise timer
    @State private var timerStartDate = Date() // Track when the timer should start
    
    @State private var iconDescription: String = "pause"
    @State private var nameDescription: String = "run"
    
    var body: some View {
        ZStack(alignment: .leading) {
            TimelineView(MetricsTimelineSchedule(from: workoutManager.session?.startDate ?? Date(),
                                                 isPaused: workoutManager.sessionState == .paused)) { context in
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Image(systemName: iconDescription)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55)
                        
                        Text(workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.title ?? "Unknown Phase")
                            .font(Font.custom("PallyVariable-Bold", size: 28))
                            .font(.title)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(Color(hex: "CFF747"))
                            .fontWeight(.bold)
                            .font(.system(size: 28))
                        
                        VStack(alignment: .leading) {
                            
                            ElapsedTimeView(elapsedTime: elapsedTime(with: context.date),
                                            workoutDuration: TimeInterval(workoutManager.currentPhase == .workout ? workoutManager.workoutDuration : workoutManager.currentPhase.duration),
                                            showSubseconds: false,
                                            showWorkoutDuration: false)
                            
                            .font(.custom("CruyffSans-Medium", size: 22))
                            .foregroundColor(Color.white)
                        }
                        .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .padding(.horizontal)
                    .background(
                        RectangleCom()
                            .foregroundColor(Color(hex: "32465D"))
                    )
                    .padding(.bottom, 5)
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.red)
                            .font(.system(size: 28))
                        
                        VStack(alignment: .leading) {
                            Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                                .font(.custom("CruyffSans-Medium", size: 22))
                                .foregroundColor(Color.white)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .padding(.bottom, 5)
                    
                    .padding()
                    .background(
                        RectangleCom()
                            .foregroundColor(Color(hex: "32465D"))
                    )
                    
                }
                .padding(.bottom, 10)
                .padding(.top, 25)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .ignoresSafeArea(.all)
                .background(Color(hex: "#18293C"))
                .scenePadding()
                .onChange(of: workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.icon) { _ in
                    iconDescription = workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.icon ?? "brain"
                    nameDescription = workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.title ?? "brain"
                }
                .onChange(of: workoutManager.isAboveHRMax) { newValue in
                    if newValue || workoutManager.isMediumHR {
                        showAlert = true
                        WKInterfaceDevice.current().play(.notification) // Trigger haptic feedback
                    }
                }
                .onChange(of: workoutManager.isMediumHR) { newValue in
                    if newValue || workoutManager.isAboveHRMax {
                        showAlert = true
                        WKInterfaceDevice.current().play(.notification) // Trigger haptic feedback
                    }
                }
                .sheet(isPresented: $showAlert) {
                    AlertHR()
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: .workoutStartedFromPhone, object: nil, queue: .main) { _ in
                        if let activityType = workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent,
                           activityType == .preparationAndRecovery {
                            self.showWarmUpAlert = true
                        }
                    }
                    iconDescription = workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.icon ?? "figure.volleyball"
                    nameDescription = workoutManager.session?.currentActivity.workoutConfiguration.activityType.exerciseTypeEquivalent?.title ?? "run"
                }
                
                
            }
            if showWarmUpAlert {
                WarmUpTimer()
                    .transition(.asymmetric(
                        insertion: .slide,
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showWarmUpAlert = false
                                timerStartDate = Date()
                                startTimer = true // Start the timer after the alert disappears
                            }
                        }
                    }
            }
            
        }
    }
    
    @MainActor func elapsedTime(with contextDate: Date) -> TimeInterval {
        return workoutManager.builder?.elapsedTime(at: contextDate) ?? 0
    }
}
