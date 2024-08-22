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
        ScrollView{
            VStack(alignment: .leading, spacing: 25){
                Image(systemName: "doc.text.below.ecg")
                    .font(.system(size: 70))
                    .transformEffect(.init(translationX: -5, y: 0))
                    .foregroundStyle(Color.breatheeeOrange)
                Text("Let’s review what we have, so far!")
                    .font(.custom("Pally", size: 34).bold())
                    .fixedSize(horizontal: false, vertical: true)
                Text("Are the following data correct?")
                
    //            HStack {
    //                VStack(alignment: .leading) {
    //                    Text("Review your health information")
    //                        .font(.custom("Cruyff Sans", size: 20).bold())
    //                        .frame(height: 30)
    //                }
    //                Spacer()
    //                Image(systemName: "chevron.right")
    //                    .imageScale(.medium)
    //                    .font(.system(.title3))
    //            }
    //            .padding(25)
    //            .background {
    //                RoundedRectangle(cornerRadius: 12, style: .continuous)
    //                    .fill(Color.onboardingButtonMidBG)
    //            }
    //            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
    //            .onTapGesture {
    //                sheetOpen = true
    //            }
                //DOB
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(Calendar.current.isDateInToday(onboardingViewModel.dob) ? "I was born on..." : onboardingViewModel.dob.stringFormat())
                                                    .font(.custom("Cruyff Sans", size: 20).bold())
                                            }
                                            Spacer()
                                            Image(systemName: Calendar.current.isDateInToday(onboardingViewModel.dob) ?  "chevron.right" : "checkmark.circle.fill")
                                                .font(.system(.title2))
                                        }
                                        .padding(25)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color.onboardingButtonMidBG)
                                        }
                                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
                
                                        //MEDICAL DIAG
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(onboardingViewModel.severity == nil ? "Select options" : "Severity level is \(onboardingViewModel.severity!.rawValue.capitalized)")
                                                    .font(.custom("Cruyff Sans", size: 20).bold())
                                            }
                                            Spacer()
                                            Image(systemName: onboardingViewModel.severity == nil ?  "chevron.right" : "checkmark.circle.fill")
                                                .font(.system(.title2))
                                        }
                                        .padding(25)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color.onboardingButtonMidBG)
                                        }
                                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
                
                                        //ACT SCORE
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(onboardingViewModel.totalScore == 0 ? "Take the test" : "Your ACT score is \(onboardingViewModel.totalScore)")
                                                    .font(.custom("Cruyff Sans", size: 20).bold())
                                            }
                                            Spacer()
                                            Image(systemName: onboardingViewModel.totalScore == 0 ?  "chevron.right" : "checkmark.circle.fill")
                                                .font(.system(.title2))
                                        }
                                        .padding(25)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color.onboardingButtonMidBG)
                                        }
                                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
                                        //INHALER
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(onboardingViewModel.isUsingInhaler == nil ? "Are you using inhalers?" : onboardingViewModel.isUsingInhaler! ? "Yes, I'm using inhalers" : "No, I don't use inhalers")
                                                    .font(.custom("Cruyff Sans", size: 20).bold())
                                            }
                                            Spacer()
                                            Image(systemName: onboardingViewModel.isUsingInhaler == nil ?  "chevron.right" : "checkmark.circle.fill")
                                                .font(.system(.title2))
                                        }
                                        .padding(25)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color.onboardingButtonMidBG)
                                        }
                                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
            }
            .padding(25)
            .frame(maxWidth: .infinity ,alignment: .leading)
            .background(Color.onboardingBG)
        }
        .background(Color.onboardingBG)
        .scrollContentBackground(.hidden)

        
//        .sheet(isPresented: $sheetOpen, content: {
//            VStack(spacing: 0){
////                HStack(alignment:.bottom){
////                    Text("Cancel")
////                    Spacer()
////                    Text("Save")
////                }
////                .padding(20)
////                .overlay(Rectangle()
////                .frame(width: nil, height: 1, alignment: .bottom)
////                .foregroundColor(Color.onboardingButtonMidBG), alignment: .bottom)
//                ScrollView{
//                    VStack(alignment: .leading, spacing: 28){
//                        Spacer().frame(height: 10)
//                        Image(systemName: "doc.text.below.ecg")
//                            .font(.system(size: 70))
//                            .transformEffect(.init(translationX: -5, y: 0))
//                            .foregroundStyle(Color.breatheeeOrange)
//                        Text("Inhaler usage")
//                            .font(.custom("Pally", size: 34).bold())
//                            .fixedSize(horizontal: false, vertical: true)
//                        Text("CORRECTNESS OF DATA")
//                            .opacity(0.45)
//                        Text("Should any of the information below looks wrong, kindly tap them and make a correction.")
//                        
//                        //DOB
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(Calendar.current.isDateInToday(onboardingViewModel.dob) ? "I was born on..." : onboardingViewModel.dob.stringFormat())
//                                    .font(.custom("Cruyff Sans", size: 20).bold())
//                            }
//                            Spacer()
//                            Image(systemName: Calendar.current.isDateInToday(onboardingViewModel.dob) ?  "chevron.right" : "checkmark.circle.fill")
//                                .font(.system(.title2))
//                        }
//                        .padding(25)
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .fill(Color.onboardingButtonMidBG)
//                        }
//                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
//                        
//                        //MEDICAL DIAG
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(onboardingViewModel.severity == nil ? "Select options" : "Severity level is \(onboardingViewModel.severity!.rawValue.capitalized)")
//                                    .font(.custom("Cruyff Sans", size: 20).bold())
//                            }
//                            Spacer()
//                            Image(systemName: onboardingViewModel.severity == nil ?  "chevron.right" : "checkmark.circle.fill")
//                                .font(.system(.title2))
//                        }
//                        .padding(25)
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .fill(Color.onboardingButtonMidBG)
//                        }
//                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
//                        
//                        //ACT SCORE
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(onboardingViewModel.totalScore == 0 ? "Take the test" : "Your ACT score is \(onboardingViewModel.totalScore)")
//                                    .font(.custom("Cruyff Sans", size: 20).bold())
//                            }
//                            Spacer()
//                            Image(systemName: onboardingViewModel.totalScore == 0 ?  "chevron.right" : "checkmark.circle.fill")
//                                .font(.system(.title2))
//                        }
//                        .padding(25)
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .fill(Color.onboardingButtonMidBG)
//                        }
//                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
//                        //INHALER
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(onboardingViewModel.isUsingInhaler == nil ? "Are you using inhalers?" : onboardingViewModel.isUsingInhaler! ? "Yes, I'm using inhalers" : "No, I don't use inhalers")
//                                    .font(.custom("Cruyff Sans", size: 20).bold())
//                            }
//                            Spacer()
//                            Image(systemName: onboardingViewModel.isUsingInhaler == nil ?  "chevron.right" : "checkmark.circle.fill")
//                                .font(.system(.title2))
//                        }
//                        .padding(25)
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .fill(Color.onboardingButtonMidBG)
//                        }
//                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
//                        
//                        
//                        
//                        Spacer()
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
    Onboarding6View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
