//
//  ContentView.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import SwiftUI

struct ContentView: View {
    private var workoutManager = WorkoutManager.shared
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: Tab = .metrics
    @State private var isSheetActive = false

    private enum Tab {
        case controls, metrics
    }

    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
        }
        .navigationTitle("Cycling")
        .navigationBarBackButtonHidden(true)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) {
            displayMetricsView()
        }
        .onChange(of: workoutManager.sessionState) { _, newValue in
            if newValue == .ended {
                isSheetActive = true
            } else if newValue == .running || newValue == .paused {
                displayMetricsView()
            }
        }
        .onAppear {
            workoutManager.requestAuthorization()
            selection = .metrics
        }
        .sheet(isPresented: $isSheetActive) {
            workoutManager.resetWorkout()
        } content: {
            SummaryView()
        }
    }

    private func displayMetricsView() {
        //withAnimation {
            selection = .metrics
        //}
    }
}

#Preview {
    ContentView()
}
