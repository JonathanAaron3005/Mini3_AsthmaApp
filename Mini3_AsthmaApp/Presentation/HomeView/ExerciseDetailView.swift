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
                    viewModel.startWorkout(exerciseType: exercise)
                }
                didStartWorkout = true
                dismiss()
            }label: {
                Text("Start Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
