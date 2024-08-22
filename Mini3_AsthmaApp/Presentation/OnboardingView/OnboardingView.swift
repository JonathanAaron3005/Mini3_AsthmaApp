//
//  OnboardingView.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 16/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository()))
    @State var currentOnboardingPage = 1
    @State var clicked = false
    var body: some View {
        ZStack{
            switch currentOnboardingPage{
            case 1:
                Onboarding1View(onboardingViewModel: onboardingViewModel)
            case 2:
                Onboarding2View(onboardingViewModel: onboardingViewModel)
            case 3:
                Onboarding3View(onboardingViewModel: onboardingViewModel)
            case 4:
                Onboarding4View(onboardingViewModel: onboardingViewModel)
            case 5:
                Onboarding5View(onboardingViewModel: onboardingViewModel)
            case 6:
                Onboarding6View(onboardingViewModel: onboardingViewModel)
            case 7:
                Onboarding7View(onboardingViewModel: onboardingViewModel)
            default:
                Text("Something wrong")
            }
            
            VStack{
                Spacer()
                ScrollView(.horizontal){
                    HStack{
                        OnboardingRollingButton(1, "Health Access", $currentOnboardingPage)
                        OnboardingRollingButton(2, "Birthdate",$currentOnboardingPage)
                        OnboardingRollingButton(3, "Personalization",$currentOnboardingPage)
                        OnboardingRollingButton(4, "AC Test",$currentOnboardingPage)
                        OnboardingRollingButton(5, "Inhaler usage",$currentOnboardingPage)
                        OnboardingRollingButton(6, "Review",$currentOnboardingPage)
                    }
                }
                .scrollIndicators(.hidden)
                .scrollClipDisabled()
                
                HStack(alignment: .center){
                    Spacer()
                    Text("Continue")
                        .colorInvert()
                    Spacer()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(clicked ? Color.onboardingButtonBottomBG : Color.onboardingButtonBottomBG.opacity(0.3))
                }
                .onTapGesture {
                    currentOnboardingPage += 1
                    if currentOnboardingPage > 7{
                        currentOnboardingPage = 1
                    }
                    withAnimation {
                        clicked = true
                    } completion: {
                        withAnimation {
                            clicked = false
                        }
                    }

                }
            }
            .padding(25)
            
        }
        
    }
}

#Preview {
    OnboardingView()
}
