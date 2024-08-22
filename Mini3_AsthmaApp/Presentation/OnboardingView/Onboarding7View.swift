//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding7View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "exclamationmark.bubble")
                .font(.system(size: 70))
                .transformEffect(.init(translationX: -5, y: 0))
                .foregroundStyle(Color.breatheeeRed)
            Text("Important to know")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("ALERTS & DETECTIONS")
                .opacity(0.4)
            Text("Breatheee may incorrectly sends you an alert. For example, Breatheee may suggest for you to cool down, while in reality, you haven’t even started any moves.")
            Text("GUIDANCE")
                .opacity(0.4)
            Text("Breatheee may suggest for you to follow a certain breathing technique, to help alleviate an asthma attack. However, it may or may not work on everyone and/or with your personal severity level.")
            
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity ,alignment: .leading)
        .background(Color.onboardingBG)
        .ignoresSafeArea()
    }
}

#Preview {
    Onboarding7View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
