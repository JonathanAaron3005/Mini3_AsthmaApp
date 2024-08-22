//
//  NewHomeView.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 18/08/24.
//

import SwiftUI

struct NewHomeView: View {
    var viewModel = HomeViewModel(exerciseUseCase: DefaultExerciseUseCase(exerciseRepo: LocalExerciseRepository()))
    let rows = [GridItem(), GridItem(),GridItem()]
    
    @State private var selectedExercise: ExerciseType?
    @State private var didStartWorkout = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ZStack{
                        TabView{
                            ForEach(viewModel.getRecommendedWorkoutTypes()) { exerciseType in
                                Group {
                                    ZStack(alignment:.bottom){
                                        Image(exerciseType.imageResource)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width, height: 600)
                                            .clipped()
                                        LinearGradient(colors: [.black.opacity(0.8),.clear,.black.opacity(0.6)], startPoint: .bottom, endPoint: .top)
                                        VStack{
                                            Text("Quickly redo your last exercise")
                                                .font(.system(.title2, design: .rounded, weight: .bold))
                                                .multilineTextAlignment(.center)
                                                .foregroundStyle(.white)
                                            HStack (alignment: .center, spacing: 0){
                                                RoundedRectangle(cornerRadius: 5.0)
                                                    .fill(Color(exerciseType.iconColor))
                                                    .aspectRatio(1, contentMode: .fit)
                                                    .frame(width: 50)
                                                    .overlay {
                                                        Image(systemName: exerciseType.icon)
                                                            .font(.title)
                                                            .foregroundStyle(.black)
                                                    }
                                                Spacer().frame(width: 14)
                                                VStack(alignment: .leading, spacing: 0) {
                                                    Text(exerciseType.title)
                                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                                        .fixedSize()
                                                    Text(exerciseType.description)
                                                        .font(.system(.caption, design: .rounded))
                                                        .fixedSize(horizontal: true, vertical: false)
                                                }
                                                .foregroundStyle(.white)
                                                Spacer()
                                                
                                                Button{
                                                    selectedExercise = exerciseType
                                                    viewModel.setSelectedExercise(exerciseType: selectedExercise!)
                                                }label:{
                                                    Text("Start")
                                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                                        .padding(.horizontal,20)
                                                        .padding(.vertical,7)
                                                        .background(.white)
                                                        .foregroundStyle(.black)
                                                        .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                                        .fixedSize()
                                                        .layoutPriority(0)
                                                }
                                                
                                                
                                            }
                                            .padding(15)
                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0, style: .continuous))
                                            .compositingGroup()
                                            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 4)
                                            Spacer().frame(height: 35)
                                        }
                                        .padding(.horizontal,30)
                                        .padding(.bottom, 15)
                                        .frame(maxWidth: UIScreen.main.bounds.width)
                                    }
                                    .frame(width: UIScreen.main.bounds.width, height: 600)
                                    .ignoresSafeArea()
                                }
                            }
                        }
                        .ignoresSafeArea()
                        .tabViewStyle(.page)
                        
                        HStack{
                            Image(.breatheeeAW)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160)
                            Spacer()
                            Image(systemName: "gear")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                        .padding(.horizontal,35)
                        .padding(.top,90)
                        
                    }
                    .frame(height: 600)
                    
                    Spacer().frame(height: 35)
                    VStack(alignment: .leading){
                        HStack{
                            Text("Curated just for you")
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                                .font(.title3)
                            Spacer()
                            Text("Show All")
                                .foregroundStyle(.blue)
                        }
                        Text("Helpful trends of your progress")
                    }
                    .padding(.horizontal, 25)
                    
                    VStack(alignment: .center, spacing: 25){
                        Spacer().frame(height: 5)
                        ZStack(alignment:.top){
                            Image(.jogging1)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            LinearGradient(colors: [.black,.clear], startPoint: .bottom, endPoint: .top)
                            VStack(alignment: .leading, spacing: 12){
                                Spacer()
                                Text("IMPROVEMENTS")
                                    .opacity(0.4)
                                Text("Slow down your pace")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("Your last jog gave you an asthma attack, with reported medium severity.")
                                    .opacity(0.8)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 40)
                            .frame(width: 350, height: 400)
                        }
                        .frame(width: 350, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        ZStack(alignment:.top){
                            Image(.breathingSmooth)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            LinearGradient(colors: [.black,.clear], startPoint: .bottom, endPoint: .top)
                            VStack(alignment: .leading, spacing: 12){
                                Spacer()
                                Text("IMPROVEMENTS")
                                    .opacity(0.4)
                                Text("Breathing smoothly\nas your strokes!")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("You’ve swam 3 times over the last week, and no asthma has been reported!")
                                    .opacity(0.8)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 40)
                            .frame(width: 350, height: 400)
                        }
                        .frame(width: 350, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        ZStack(alignment:.top){
                            Image(.outofBreath)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            LinearGradient(colors: [.black,.clear], startPoint: .bottom, endPoint: .top)
                            VStack(alignment: .leading, spacing: 12){
                                Spacer()
                                Text("IMPROVEMENTS")
                                    .opacity(0.4)
                                Text("Running out of breath")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("Your last jog gave you an asthma attack, with reported medium severity.")
                                    .opacity(0.8)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 40)
                            .frame(width: 350, height: 400)
                        }
                        .frame(width: 350, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("More exercises for you")
                                    .fontDesign(.rounded)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Spacer()
                                Text("Show All")
                                    .foregroundStyle(.blue)
                            }
                            Text("Pick any of the following, and\nquickly start one")
                        }
                        .padding(.horizontal, 25)
                        
                        
                        ScrollView(.horizontal){
                            LazyHGrid(rows: rows, spacing: 20){
                                ForEach(viewModel.getWorkoutTypes()) { exerciseType in
                                    HStack (alignment: .center, spacing: 0){
                                        RoundedRectangle(cornerRadius: 5.0)
                                            .fill(Color(exerciseType.iconColor))
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 50)
                                            .overlay {
                                                Image(systemName: exerciseType.icon)
                                                    .font(.title)
                                                    .foregroundStyle(.black)
                                            }
                                        Spacer().frame(width: 14)
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text(exerciseType.title)
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .fixedSize()
                                            Text(exerciseType.description)
                                                .font(.system(.caption, design: .rounded))
                                                .fixedSize(horizontal: true, vertical: false)
                                        }
                                        Spacer()
                                        Button{
                                            selectedExercise = exerciseType
                                            viewModel.setSelectedExercise(exerciseType: selectedExercise!)
                                        }label:{
                                            Text("Start")
                                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                                .padding(.horizontal,20)
                                                .padding(.vertical,7)
                                                .foregroundStyle(.white)
                                                .background(.blue)
                                                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                                .fixedSize()
                                                .layoutPriority(0)
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                    
                    
                    
                    
                }
                .sheet(item: $selectedExercise) { exercise in
                    ExerciseDetailView(viewModel: viewModel, didStartWorkout: $didStartWorkout)
                }
                .navigationDestination(isPresented: $didStartWorkout) {
                    WorkoutPhaseView()
                }
            }
            .background(.onboardingBG)
            .scrollContentBackground(.hidden)
        .ignoresSafeArea()
        }
    }
}

#Preview {
    NewHomeView()
}
