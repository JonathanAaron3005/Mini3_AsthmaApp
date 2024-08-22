//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding2View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @State var sheetOpen = false
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "balloon.2")
                .font(.system(size: 70))
                .transformEffect(.init(translationX: -5, y: 0))
                .foregroundStyle(Color.breatheeeOrange)
            Text("Your date of birth, please?")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            DatePicker("", selection: $onboardingViewModel.dob, displayedComponents: .date)
                .datePickerStyle(.wheel)
            
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity ,alignment: .leading)
        .background(Color.onboardingBG)
        .ignoresSafeArea()
//        .sheet(isPresented: $sheetOpen, content: {
//            VStack(spacing: 0){
//                HStack(alignment:.bottom){
//                    Button {
//                        sheetOpen.toggle()
//                    } label: {
//                        Text("Cancel")
//                    }
//                    Spacer()
//                }
//                .padding(20)
//                .overlay(Rectangle()
//                    .frame(width: nil, height: 1, alignment: .bottom)
//                    .foregroundColor(Color.onboardingButtonMidBG), alignment: .bottom)
//                ScrollView{
//                    VStack(alignment: .leading, spacing: 28){
//                        
//                        Spacer().frame(height: 10)
//                        Image(systemName: "balloon.2")
//                            .font(.system(size: 70))
//                            .transformEffect(.init(translationX: -5, y: 0))
//                            .foregroundStyle(Color.breatheeeOrange)
//                        Text("Date of birth")
//                            .font(.custom("Pally", size: 34).bold())
//                            .fixedSize(horizontal: false, vertical: true)
//                        DatePicker("I was born on...", selection: $onboardingViewModel.dob, displayedComponents: .date)
//                
//                        
//                        Text("We’ll never share your data with anyone. Learn more from our [privacy policy](www.google.com).")
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .padding(25)
//                    .frame(maxWidth: .infinity ,alignment: .leading)
//                }
//                .background(Color.onboardingBG)
////                .scrollContentBackground(.hidden)
//            }
//        })
    }
}

#Preview {
    Onboarding2View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
