//
//  ExerciseDetailView.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 16/08/24.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    @Binding var didStartWorkout: Bool
    
    @State private var bringReliverInhaler = false
    @State private var usePreventiveInhaler = false
    @State private var isPreparationCompleted = false
    
    @State private var showWorkoutDurationSheet = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .foregroundStyle(.blue)
                                .fontWeight(.semibold)
                                .padding(20)
                                .font(.title3)
                        }
                        Spacer()
                    }
                    .background(.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black.opacity(0.2)),
                        alignment: .bottom
                    )
                    .padding(.horizontal, -15)
                    .padding(.top, -15)
                    
                    
                    VStack(alignment: .leading) {
                        Image(systemName: viewModel.selectedWorkout?.icon ?? "figure.pool.swim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .padding()
                            .padding(.vertical, 5)
                            .background(Color(viewModel.selectedWorkout?.iconColor ?? "BreatheeeTeal"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Text(viewModel.selectedWorkout?.title ?? "Swimming")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        
                        Text("Considered safe and healthy by the community, the rather hot and humid air near water is said to reduce the potential of asthma attack.")
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Preparation Checklist")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 3)
                        Text("Better be safe than sorry, yes?")
                            .font(.body)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ChecklistItemView(isChecked: $bringReliverInhaler, text: "Use preventive inhaler")
                            ChecklistItemView(isChecked: $usePreventiveInhaler, text: "Bring reliever inhaler")
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("You're the boss")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        Text("You know your body the best, so you decide your own exercise portion")
                            .font(.body)
                            .padding(.bottom, 5)
                        Text("Experts find it comforting if you could portion it into a suitable length. This way, you won't over-exert yourself.")
                            .font(.caption)
                            .opacity(0.6)
                            .padding(.bottom, 15)
                        
                        Button {
                            showWorkoutDurationSheet = true
                        }label: {
                            HStack {
                                Text("\(viewModel.workoutDuration) minutes")
                                    .font(.body)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                    .foregroundStyle(.black.opacity(0.6))
                            }
                            .padding()
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .shadow(radius: 5)
                            )
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("YOUR SAFETY COMES FIRST")
                            .foregroundStyle(.gray)
                            .padding(.bottom, 5)
                        Text(viewModel.selectedWorkout?.disclaimer ?? "Swimming comes with risk. For example, excess chlorine in the water may irritate your airways, thus triggering an asthma. We’ll be with you. Always exercise caution. Get out off the water, in the chance of asthma symptoms.")
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding(.bottom, 150)
                .padding()
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: isPreparationCompleted ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.black)
                    Text("I have completed all preparations")
                }
                .padding(.top, 17)
                .padding(.bottom, 7)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.17)) {
                        isPreparationCompleted.toggle()
                    }
                }
                
                Button{
                    if !viewModel.isWorkingOut(){
                        viewModel.startWarmup()
                    }
                    didStartWorkout = true
                    dismiss()
                }label: {
                    CustomButton(text: "Proceed with warm up", color: .black.opacity(0.88))
                }
            }
            .padding()
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .ignoresSafeArea()
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background(.gray.opacity(0.1))
        .sheet(isPresented: $showWorkoutDurationSheet) {
            SetWorkoutDurationView(viewModel: viewModel)
        }
    }
}

struct ChecklistItemView: View {
    @Binding var isChecked: Bool
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .foregroundStyle(isChecked ? .gray : .black)
                .strikethrough(isChecked)
            Spacer()
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.black.opacity(0.6))
                .opacity(isChecked ? 0.7 : 1)
        }
        .padding()
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isChecked ? .gray : .black, lineWidth: 1)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.17)) {
                isChecked.toggle()
            }
        }
    }
}




