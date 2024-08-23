//
//  CustomExerciseAlert.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Kevin Fairuz on 23/08/24.
//

import SwiftUI

import SwiftUI

struct CustomExerciseAlert: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hey, 1 min is up!")
                .font(.custom("PallyVariable-Bold", size: 24))
                .foregroundColor(.black)
            
            Text("You totally crushed today’s exercise!")
                .font(.custom("PallyVariable-Bold", size: 18))
                .foregroundColor(.black)
            
            Image(systemName: "face.smiling")
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color(hex: "#D5FF00")) // Set your custom background color
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .shadow(radius: 5)
    }
}
