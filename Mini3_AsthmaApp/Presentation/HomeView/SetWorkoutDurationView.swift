//
//  SetWorkoutDurationView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 19/08/24.
//

import SwiftUI

struct SetWorkoutDurationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.workoutManager.workoutDuration = 30
                    dismiss()
                }) {
                    Text("Cancel")
                        .foregroundStyle(.blue)
                        .fontWeight(.semibold)
                        .padding(20)
                        .font(.title3)
                }
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                        .foregroundStyle(.blue)
                        .fontWeight(.semibold)
                        .padding(20)
                        .font(.title3)
                }
            }
            .background(.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black.opacity(0.2)),
                alignment: .bottom
            )
            .padding(.horizontal, -15)
            .padding(.top, -15)
            
            Spacer()
            
            VStack(spacing: 20) {
                Text("\(viewModel.workoutManager.workoutDuration) minutes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    Button(action: {
                        if viewModel.workoutManager.workoutDuration > 5 {
                            viewModel.workoutManager.workoutDuration -= 5
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.workoutManager.workoutDuration += 5
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
                .padding(.horizontal, 50)
            }
            
            Spacer()
        }
        .padding()
        .background(.gray.opacity(0.1))
    }
}

