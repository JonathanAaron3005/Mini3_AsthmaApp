//
//  IndicatorIphone.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Kevin Fairuz on 22/08/24.
//

import SwiftUI

struct IndicatorIphone: View {
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "iphone.and.arrow.forward")
                .resizable()
                .frame(width:55, height: 73)
            VStack{
                Text("Please start an exercise on your phone ")
                    .font(.custom("PallyVariable-Bold_Regular", size: 18))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
        }
        .padding()
        .padding(.top, 40)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "18293C"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    IndicatorIphone()
}
