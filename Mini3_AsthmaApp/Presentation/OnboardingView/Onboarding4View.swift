//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding4View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @Environment(\.openURL) var openLink
    @State var sheetOpen = false
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "checklist")
                .font(.system(size: 70))
                .foregroundStyle(Color.breatheeePurple)
                .transformEffect(.init(translationX: -5, y: 0))
            Text("Let’s validate with an asthma control test!")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("ACT helps healthcare practitioner to understand about how well your asthma symptoms are under control. \n\nThrough the same test, we hope we can understand more about you!")
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Take the test")
                        .font(.custom("Cruyff Sans", size: 20).bold())
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .font(.system(.title3))
            }
            .padding(25)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.onboardingButtonMidBG)
            }
            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
            .onTapGesture {
                sheetOpen = true
            }
            Text("We outsourced this test from [asthmacontroltest.com](https://www.asthmacontroltest.com), and the result of this test will never be shared.")
            
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity ,alignment: .leading)
        .background(Color.onboardingBG)
        .ignoresSafeArea()
        .sheet(isPresented: $sheetOpen, content: {
            VStack(spacing: 0){
                HStack(alignment:.bottom){
                    Text("Cancel")
                    Spacer()
                    Text("Save")
                }
                .padding(20)
                .overlay(Rectangle()
                    .frame(width: nil, height: 1, alignment: .bottom)
                    .foregroundColor(Color.onboardingButtonMidBG), alignment: .bottom)
                ScrollView{
                    VStack(alignment: .leading, spacing: 28){
                        
                        Spacer().frame(height: 10)
                        Image(systemName: "checklist")
                            .font(.system(size: 70))
                            .foregroundStyle(Color.breatheeePurple)
                            .transformEffect(.init(translationX: -5, y: 0))
                        Text("Asthma Control Test")
                            .font(.custom("Pally", size: 34).bold())
                            .fixedSize(horizontal: false, vertical: true)
                        VStack(alignment: .leading, spacing: 15){
                            Text("This test, which was acquired from asthmacontroltest.com, is not intended for self-diagnosis; and may (in some cases) not be representative of your actual asthma.")
                            Text("Breatheee uses this test to get the general idea about your asthma condition -- not to be used as supporting document, in case of emergencies.")
                            
                        }
                        
                        ForEach(0..<onboardingViewModel.questions.count, id: \.self) { questionIndex in
                            VStack(alignment: .leading, spacing: 15) {
                                Text("QUESTION \(questionIndex+1)")
                                    .opacity(0.45)
                                Text(onboardingViewModel.questions[questionIndex].text)
                                
                                ForEach(0..<onboardingViewModel.questions[questionIndex].options.count, id: \.self) { optionIndex in
                                    Button(action: {
                                        onboardingViewModel.selectAnswer(for: questionIndex, optionIndex: optionIndex)
                                    }) {
                                        Image(systemName: onboardingViewModel.selectedAnswers[questionIndex] == onboardingViewModel.questions[questionIndex].options[optionIndex].score ? "circle.circle.fill" : "circle")
                                            .font(.title3)
                                            .transformEffect(.init(translationX: 0, y: 1))
                                            .frame(width: 20, height: 20)
                                        
                                        Text(onboardingViewModel.questions[questionIndex].options[optionIndex].text)
                                    }
                                    .padding(.vertical, 2)
                                    .foregroundStyle(Color.onboardingButtonBottomBG)
                                }
                            }
                        }

                        Text("We’ll never share your data with anyone. Learn more from our [privacy policy](www.google.com).")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                }
                .background(Color.onboardingBG)
            }
        })
    }
}

#Preview {
    Onboarding4View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
