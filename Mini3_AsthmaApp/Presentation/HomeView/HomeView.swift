//
//  HomeView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel(
        exerciseUseCase: DefaultExerciseUseCase(
            exerciseRepo: LocalExerciseRepository()
        )
    )
    @State private var didStartWorkout = false
    @State private var selectedExercise: ExerciseType?
    @State private var gotoOnboarding = false
    @AppStorage("hasDoneOnboarding") private var hasDoneOnboarding: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home View")
                
                List(viewModel.getWorkoutTypes(), id: \.self) { exerciseType in
                    Button(action: {
                        selectedExercise = exerciseType
                        viewModel.setSelectedExercise(exerciseType: selectedExercise!)
                    }) {
                        Text(exerciseType.title)
                    }
                }
                
            }
            .onAppear() {
                viewModel.retrieveRemoteSession()
            }
            .sheet(item: $selectedExercise) { exercise in
                ExerciseDetailView(viewModel: viewModel, didStartWorkout: $didStartWorkout)
            }
            .navigationDestination(isPresented: $didStartWorkout) {
                WorkoutPhaseView()
            }
            .navigationBarTitle("Mirroring Workout")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $gotoOnboarding, destination:{
                OnboardingView()
                    .navigationBarBackButtonHidden()
            })
            .onAppear{
                if hasDoneOnboarding == false{
                    gotoOnboarding = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
