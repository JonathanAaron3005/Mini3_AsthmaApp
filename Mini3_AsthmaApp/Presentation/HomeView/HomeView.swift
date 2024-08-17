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
    
    @State private var triggerAuthorization = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home View")
                
                List(viewModel.getWorkoutTypes(), id: \.self) { exerciseType in
                    Button(action: {
                        selectedExercise = exerciseType
                        viewModel.setSelectedExercise(exerciseType: selectedExercise!.healthKitEquivalent)
                    }) {
                        Text(exerciseType.rawValue.capitalized)
                    }
                }
                
            }
            .onAppear() {
                triggerAuthorization.toggle()
                viewModel.retrieveRemoteSession()
            }
            .healthDataAccessRequest(store: viewModel.getHealthStore(),
                                     shareTypes: viewModel.getTypesToShare(),
                                     readTypes: viewModel.getTypesToRead(),
                                     trigger: triggerAuthorization, completion: { result in
                switch result {
                case .success(let success):
                    print("\(success) for authorization")
                case .failure(let error):
                    print("\(error) for authorization")
                }
            })
            .sheet(item: $selectedExercise) { exercise in
                ExerciseDetailView(exercise: exercise, viewModel: viewModel, didStartWorkout: $didStartWorkout)
            }
            .navigationDestination(isPresented: $didStartWorkout) {
                MirroringWorkoutView()
            }
            .navigationBarTitle("Mirroring Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
