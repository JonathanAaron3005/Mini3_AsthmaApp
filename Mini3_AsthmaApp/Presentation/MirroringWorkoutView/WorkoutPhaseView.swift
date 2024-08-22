//
//  WorkoutPhaseSelectionView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 20/08/24.
//

import SwiftUI

struct WorkoutPhaseView: View {
    @ObservedObject private var viewModel = WorkoutPhaseViewModel(exerciseUseCase: DefaultExerciseUseCase(exerciseRepo: LocalExerciseRepository()))
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        WorkoutPhaseButton(title: "Warm up", phase: .warmup, selectedPhase: $viewModel.selectedPhase)
                        WorkoutPhaseButton(title: "Exercise", phase: .workout, selectedPhase: $viewModel.selectedPhase)
                        WorkoutPhaseButton(title: "Cool Down", phase: .cooldown, selectedPhase: $viewModel.selectedPhase)
                    }
                    .padding()
                    .padding(.top, 40)
                }
                .padding(.top)
                
                Spacer()
                
                MirroringWorkoutView(viewModel: viewModel)
                
                Spacer()
                
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct WorkoutPhaseButton: View {
    let title: String
    let phase: WorkoutPhase
    @Binding var selectedPhase: WorkoutPhase
    
    var body: some View {
        Button(action: {
            selectedPhase = phase
        }) {
            HStack {
                HStack (spacing: -3){
                    Image(systemName: "\(phase.step).circle.fill")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(title)
                        .font(.headline)
                        .padding()
                }
                .foregroundStyle(selectedPhase == phase ? .black : .gray)
                .opacity(selectedPhase == phase ? 0.7 : 0.5)
                
                Image(systemName: phase.step < 3 ? "arrow.right" : "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(.gray.opacity(0.5))
            }
        }
        .disabled(true)
    }
}

struct WorkoutPhaseView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutPhaseView()
    }
}
