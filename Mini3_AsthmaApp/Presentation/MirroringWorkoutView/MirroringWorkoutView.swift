//
//  MirroringWorkoutView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI

struct MirroringWorkoutView: View {
    
    var viewModel = MirroringWorkoutViewModel(exerciseUseCase: DefaultExerciseUseCase(exerciseRepo: LocalExerciseRepository()))
    
    var body: some View {
        VStack {
            Text(viewModel.getActiveWorkout()?.title ?? "Unknown")
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
            .padding(.top, 10)
            .disabled(!viewModel.isWorkingOut())
        }
    }
}

#Preview {
    MirroringWorkoutView()
}
