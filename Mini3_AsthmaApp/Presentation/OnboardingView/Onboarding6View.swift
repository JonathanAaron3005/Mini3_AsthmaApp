//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding6View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @State var sheetOpen = false
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "doc.text.below.ecg")
                .font(.system(size: 70))
                .transformEffect(.init(translationX: -5, y: 0))
                .foregroundStyle(Color.breatheeeOrange)
            Text("Let’s review what we have, so far!")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("Are the following data correct?")
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Review your health information")
                        .font(.custom("Cruyff Sans", size: 20).bold())
                        .frame(height: 30)
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
                        Image(systemName: "doc.text.below.ecg")
                            .font(.system(size: 70))
                            .transformEffect(.init(translationX: -5, y: 0))
                            .foregroundStyle(Color.breatheeeOrange)
                        Text("Inhaler usage")
                            .font(.custom("Pally", size: 34).bold())
                            .fixedSize(horizontal: false, vertical: true)
                        Text("CORRECTNESS OF DATA")
                            .opacity(0.45)
                        Text("Should any of the information below looks wrong, kindly tap them and make a correction.")
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Yes, I use inhaler.")
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
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(Calendar.current.isDateInToday(onboardingViewModel.dob) ? "I was born on..." : onboardingViewModel.dob.stringFormat())
                                    .font(.custom("Cruyff Sans", size: 20).bold())
                            }
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
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
    Onboarding6View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
