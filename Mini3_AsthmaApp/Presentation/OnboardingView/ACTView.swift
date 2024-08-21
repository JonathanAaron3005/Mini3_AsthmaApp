import Foundation
import SwiftUI

struct ACTView: View {
    
    @StateObject private var viewModel = OnboardingViewModel(userUseCase: DefaultUserUseCase(userRepo: LocalUserRepository()))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<viewModel.questions.count, id: \.self) { questionIndex in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.questions[questionIndex].text)
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        ForEach(0..<viewModel.questions[questionIndex].options.count, id: \.self) { optionIndex in
                            Button(action: {
                                viewModel.selectAnswer(for: questionIndex, optionIndex: optionIndex)
                            }) {
                                Text(viewModel.questions[questionIndex].options[optionIndex].text)
                                    .padding()
                                    .background(viewModel.selectedAnswers[questionIndex] == viewModel.questions[questionIndex].options[optionIndex].score ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    viewModel.submitAsthmaControlScore()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top)
        }
    }
}

struct ACTView_Preview: PreviewProvider {
    static var previews: some View {
        ACTView()
    }
}
