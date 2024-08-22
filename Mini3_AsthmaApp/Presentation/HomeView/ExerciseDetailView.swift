//
//  ExerciseDetailView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.dismiss) var dismiss
    var exercise: ExerciseType
    var viewModel: HomeViewModel
    @Binding var didStartWorkout: Bool
    
    var body: some View {
        var manager = WorkoutManager.shared
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                            .underline()
                    }
                }
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                
                Spacer()
            }
            
            Text(exercise.rawValue)
                .font(.largeTitle)
            
            Button{
                if !viewModel.isWorkingOut(){
                    viewModel.startWorkout()
                }
                didStartWorkout = true
                dismiss()
            }label: {
                Text("Start Workout")
                    .frame(maxWidth: .infinity) // Membuat tombol memenuhi lebar layar
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal) // Memberikan padding di sisi horizontal
            
            Button {
                viewModel.stopWorkout()
            } label: {
                Text("End Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10) // Memberikan jarak antara tombol End Workout dan Start Workout
            .disabled(!viewModel.isWorkingOut())
            
            Spacer()
        }
    }
}
