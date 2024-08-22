//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding5View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @State var sheetOpen = false
    @State var q1: Bool?
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "questionmark.circle")
                .font(.system(size: 70))
                .transformEffect(.init(translationX: -5, y: 0))
                .foregroundStyle(Color.breatheeeTeal)
            Text("Last question! Do you happen to use any inhalers?")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("We’ll remind you to bring them before every exercises.")
            
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
                    Spacer()
                    Button {
                        sheetOpen.toggle()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                }
                .padding(20)
                .overlay(Rectangle()
                    .frame(width: nil, height: 1, alignment: .bottom)
                    .foregroundColor(Color.onboardingButtonMidBG), alignment: .bottom)
                ScrollView{
                    VStack(alignment: .leading, spacing: 28){
                        
                        Spacer().frame(height: 10)
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 70))
                            .transformEffect(.init(translationX: -5, y: 0))
                            .foregroundStyle(Color.breatheeeTeal)
                        Text("Inhaler usage")
                            .font(.custom("Pally", size: 34).bold())
                            .fixedSize(horizontal: false, vertical: true)
                        VStack(alignment: .leading, spacing: 15){
                            Text("Are you using an inhaler of any type?")
                            VStack(alignment:.leading){
                                RadioButton(tag: true, selection: $q1, label: "Yes, I use inhaler(s)")
                                RadioButton(tag: false, selection: $q1, label: "No, I don’t use any inhalers")
                            }.onChange(of: q1) { oldValue, newValue in
                                onboardingViewModel.isUsingInhaler = q1 ?? false
                            }
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
    Onboarding5View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
