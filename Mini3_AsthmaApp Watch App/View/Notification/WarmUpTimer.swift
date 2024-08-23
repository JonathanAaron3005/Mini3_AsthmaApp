//
//  WarmUpTimer.swift
//  Breatheee Watch App
//
//  Created by Kevin Fairuz on 16/08/24.
//

import SwiftUI

struct WarmUpTimer: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Starting Warm Up!")
                .font(Font.custom("PallyVariable-Bold_Regular", size: 28))
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            VStack {
                Text("Keep the spirit up! Ready to go?")
                    .font(Font.custom("CruyffSans-Light", size: 18))
                    .foregroundColor(.black)
            }
            .padding(.top, 5)
            
            HStack {
                Spacer() // Push the image to the right
                Image("Breatheee-smile")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 41, maxHeight: 53)
            }
            .padding(.top, 5)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 32)
        
        .background(Color(hex: "#CEF74A"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    WarmUpTimer()
}
