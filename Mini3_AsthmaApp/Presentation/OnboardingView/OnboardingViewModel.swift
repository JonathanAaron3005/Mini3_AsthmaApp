import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var dob = Date()
    
    @Published var severity: SeverityLevel?
    
    @Published var questions: [Question]
    @Published var selectedAnswers: [Int] 
    @Published var totalScore: Int = 0
    
    @Published var isUsingInhaler: Bool = false
    
    @Published var HRMax: Int?
    
    private let userUseCase: UserUseCase
    
    init(userUseCase: UserUseCase) {
        self.userUseCase = userUseCase
        self.questions = []
        self.selectedAnswers = []
        self.questions = Question.generateQuestions()
        self.selectedAnswers = Array(repeating: 0, count: questions.count)
    }
    
    func selectAnswer(for questionIndex: Int, optionIndex: Int) {
        let score = questions[questionIndex].options[optionIndex].score
        selectedAnswers[questionIndex] = score
    }
    
    func calculateTotalScore() -> Int {
        return selectedAnswers.reduce(0, +)
    }
    
    func submitAsthmaControlScore() {
        totalScore = calculateTotalScore()
        print(totalScore)
    }
    
    func submitAllData() {
        let age = dob.age()
        
    }
}
