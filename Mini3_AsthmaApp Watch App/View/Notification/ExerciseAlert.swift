//
//  ExerciseAlert.swift
//  Breatheee Watch App
//
//  Created by Kevin Fairuz on 16/08/24.
//

import SwiftUI

struct AlertView: View {
    let backgroundColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 15) {
                    Image("breathe-safe")
                        .resizable()
                        .frame(width: 50,height: 50)
                    VStack {
                        Text(title)
                            .font(Font.custom("PallyVariable-Bold_Regular", size: 20))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    
                    VStack {
                        Text(subtitle)
                            .font(Font.custom("CruyffSans-Light", size: 14))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                }
                .padding(.top,50)
                .padding(.horizontal, 20)
                .background(backgroundColor)
                
                .edgesIgnoringSafeArea(.all)
            }
        }
}

struct ExerciseAlert: View {
    var body: some View {
        VStack(spacing: 20) {
            AlertView(
                backgroundColor: Color.green,
                title: "30 minutes is up!",
                subtitle: "Well done!"
            )
            AlertView(
                backgroundColor: Color.yellow,
                title: "Your heart rate just reached 144 bpm.",
                subtitle: "Let’s take it slow, okay?"
            )
            AlertView(
                backgroundColor: Color.red,
                title: "Your heart rate surpassed 144 bpm.",
                subtitle: "Hang on, let’s cool down!"
            )
        }
    }
}



#Preview {
    AlertView(backgroundColor: Color.red, title: "Your heart rate surpassed 144 bpm.", subtitle:  "Hang on, let’s cool down!")
}
