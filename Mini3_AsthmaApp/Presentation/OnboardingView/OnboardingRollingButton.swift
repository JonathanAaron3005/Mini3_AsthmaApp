//
//  OnboardingRollingButton.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 16/08/24.
//

import SwiftUI

struct OnboardingRollingButton: View {
    var number: Int
    var text: String
    @Binding var currentlyDone: Int
    
    init(_ number: Int,_ text: String,_ done: Binding<Int>) {
        self.number = number
        self.text = text
        self._currentlyDone = done
    }
    
    var body: some View {
        HStack{
            if currentlyDone > number{
                Image(systemName: "checkmark.circle")
            }else{
                Image(systemName: "\(number).circle")
            }
            Text(text)
        }
        .foregroundStyle(currentlyDone > number ? Color.onboardingBG : Color.onboardingButtonBottomBG)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(currentlyDone > number ? Color.onboardingButtonBottomBG : Color.onboardingBG)
                .strokeBorder(lineWidth:1)

        }
    }
}

#Preview {
    OnboardingRollingButton(1,"Health", .constant(1))
}
