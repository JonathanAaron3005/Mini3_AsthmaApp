//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding3View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @State var sheetOpen = false
    @State var pickedOp1 = 0
    @State var selectedOption: Int?
    @State var selectedOptionHaveMedicalDiag: Bool?
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "stethoscope")
                .font(.system(size: 70))
                .foregroundStyle(Color.breatheeeRed)
            Text("Have you gotten any medical diagnosis before?")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("These data will help us tailor the right doses of exercise, just for you~")
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Select options")
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
                        Image(systemName: "stethoscope")
                            .font(.system(size: 70))
                            .foregroundStyle(Color.breatheeeRed)
                        Text("Medical diagnosis")
                            .font(.custom("Pally", size: 34).bold())
                            .fixedSize(horizontal: false, vertical: true)
                        VStack(alignment: .leading, spacing: 15){
                            Text("Have you received any medical diagnosis?")
                            VStack(alignment:.leading){
                                RadioButton(tag: true, selection: $selectedOptionHaveMedicalDiag, label: "I have received medical diagnosis")
                                RadioButton(tag: false, selection: $selectedOptionHaveMedicalDiag, label: "I have NOT received medical diagnosis")
                            }
                        }
                        
                        if(selectedOptionHaveMedicalDiag == true) {
                            VStack(alignment: .leading, spacing: 15){
                                Text("How severe was your asthma?")
                                VStack(alignment:.leading){
                                    RadioButton(tag: 1, selection: $selectedOption, label: "I’m not sure")
                                    RadioButton(tag: 2, selection: $selectedOption, label: "Severe")
                                    RadioButton(tag: 3, selection: $selectedOption, label: "Moderate")
                                    RadioButton(tag: 4, selection: $selectedOption, label: "Mild")
                                    RadioButton(tag: 5, selection: $selectedOption, label: "Intermittent")
                                }
                            }

                        }
                        Text("How high was your maximum heart rate?")
                        Text("We’ll never share your data with anyone. Learn more from our [privacy policy](www.google.com).")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                }
                .background(Color.onboardingBG)
//                .scrollContentBackground(.hidden)
            }
        })
    }
}

#Preview {
    Onboarding3View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
