//
//  OnBoarding.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 15/08/24.
//

import SwiftUI

struct Onboarding1View: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    @State var triggerAuth: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            Spacer().frame(height: 100)
            Image(systemName: "heart.text.square")
                .foregroundStyle(Color.breatheeeRed)
                .font(.system(size: 70))
                .transformEffect(.init(translationX: -5, y: 0))
            Text("We’ll need to access your health data.")
                .font(.custom("Pally", size: 34).bold())
                .fixedSize(horizontal: false, vertical: true)
            Text("We need them to be able to record your exercises and monitor your asthma during exercises.")
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Grant health access")
                        .font(.custom("Cruyff Sans", size: 20).bold())
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(.title))
            }
            .padding(25)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.onboardingButtonMidBG)
            }
            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
            .onAppear() {
                triggerAuth = true
            }
            
            Text("We promise we’ll keep it safe and never share it with anyone. Learn more from our privacy policy.")
            Spacer()
        }
        .padding(25)
        .frame(maxWidth: .infinity ,alignment: .leading)
        .background(Color.onboardingBG)
        .ignoresSafeArea()
        .healthDataAccessRequest(store: onboardingViewModel.getHealthStore(),
                                 shareTypes: onboardingViewModel.getTypesToShare(),
                                 readTypes: onboardingViewModel.getTypesToRead(),
                                 trigger: triggerAuth, completion: { result in
            switch result {
            case .success(let success):
                print("\(success): success for authorization")
            case .failure(let error):
                print("\(error): error for authorization")
            }
        })
    }
}

#Preview {
    Onboarding1View(onboardingViewModel: OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository())))
}
