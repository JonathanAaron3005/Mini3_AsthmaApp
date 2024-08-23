//
//  AlertHR.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Kevin Fairuz on 20/08/24.
//
import SwiftUI

struct AlertHR: View {
    private var workoutManager = WorkoutManager.shared
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack {
                    HStack {
                        Image(workoutManager.isAboveHRMax ? "Breatheee-bad-white" : "Breatheee-bad-black" )
                            .resizable()
                            .frame(width: 32, height: 38)
                        
                        Text(workoutManager.isAboveHRMax ? "Let's cooldown!" : "Take it easy, ok?")
                            .font(.custom("PallyVariable-Bold_Medium", size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(workoutManager.isAboveHRMax ? Color.white : Color.black)
                            
                    }
                    .padding()
                    
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                        
                        Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                            .font(.custom("Cruyff Sans", size: 24))
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    
                    .background(
                        RectangleCom()
                            .foregroundColor(Color.black.opacity(0.5))
                    )
                    .padding(.top, 10)
                    
                    VStack {
                        Text(workoutManager.isAboveHRMax ? "Your heart rate has surpassed \(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0)))) bpm, your optimal exercise condition." : "Your heart rate has surpassed \(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0)))) bpm, your optimal exercise condition.")
                            .font(Font.custom("CruyffSans-Light", size: 16))
                            .foregroundColor(workoutManager.isAboveHRMax ? Color.white : Color.black)
                    }
                    .padding(.horizontal)
                    .padding(.top, 15)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding([.bottom, .top],40)
                .background(workoutManager.isAboveHRMax ? Color.red : Color.yellow)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
