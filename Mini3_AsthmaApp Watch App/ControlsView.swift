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
                workoutManager.sessionState == .running ? workoutManager.session?.pause() : workoutManager.session?.resume()
            } label: {
                let title = workoutManager.sessionState == .running ? "Pause" : "Resume"
                let systemImage = workoutManager.sessionState == .running ? "pause" : "play"
                HStack{
                    Image(systemName: systemImage)
                    Text(title)
                }
            }
            .disabled(!workoutManager.sessionState.isActive)
            .tint(.blue)
            
            Button {
                workoutManager.session?.stopActivity(with: .now)
            } label: {
                Text("End")
            }
            .tint(.red)
            .disabled(!workoutManager.sessionState.isActive)
        }
    }
}

