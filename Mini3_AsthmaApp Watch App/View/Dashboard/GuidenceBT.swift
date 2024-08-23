//
//  GuidenceBT.swift
//  Breatheee Watch App
//
//  Created by Kevin Fairuz on 15/08/24.
//

import SwiftUI

struct GuidenceBT: View {
    
    var body: some View {
        
            VStack(alignment: .center) {
                Text("Are you having an ashtma attack?")
                    .font(.custom("PallyVariable-Bold_Regular", size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 25)
                Text("Let’s calm down...")
                    .font(.custom("PallyVariable-Bold_Regular", size: 18))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
               
                
                VStack {
                    NavigationLink(destination: BreathAnimation()) { // Replace 'NextView' with your destination view
                        Image(systemName: "wind.circle.fill")
                            .resizable()
                            .foregroundColor(Color(hex: "3DD5D5"))
                            .frame(width: 82, height: 82)
                    }
                    .buttonStyle(.plain)
                    .buttonStyle(.plain)
                }
                
            }
            
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(hex: "18293C"))
            .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    @State var s = 1
//    return GuidenceBT(router: Router())
//}

