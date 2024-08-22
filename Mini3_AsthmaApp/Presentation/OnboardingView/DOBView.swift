//
//  DOBView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 19/08/24.
//

import SwiftUI

struct DOBView: View {
    @StateObject private var viewModel = OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository()))
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Please select your date of birth")
                    .font(.title)
                    .padding()
                
                DatePicker("Date of Birth", selection: $viewModel.dob, displayedComponents: .date)
                    .padding()
                
                NavigationLink(destination: ACTView()) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            print(viewModel.dob.age())
                        }
                }
                .padding(.top, 20)
            }
            .navigationTitle("DOB")
        }
    }
}

struct DOBView_Previews: PreviewProvider {
    static var previews: some View {
        DOBView()
    }
}
