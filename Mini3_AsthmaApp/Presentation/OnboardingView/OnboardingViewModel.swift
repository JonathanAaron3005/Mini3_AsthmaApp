import Foundation
import HealthKit

class OnboardingViewModel: ObservableObject {
    let workoutManager = WorkoutManager.shared
    @Published var dob = Date()
    
    @Published var severity: SeverityLevel?
    
    @Published var questions: [Question]
    @Published var selectedAnswers: [Int] 
    @Published var totalScore: Int = 0
    
    @Published var isUsingInhaler: Bool = false
    
    @Published var HRMax: Double?
    
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
        userUseCase.saveUser(dob: dob, severity: severity, totalScore: totalScore, isUsingInhaler: isUsingInhaler, HRMax: HRMax)
    }
    
    func getHealthStore() -> HKHealthStore {
        return workoutManager.healthStore
    }
    
    func getTypesToShare() -> Set<HKSampleType> {
        return workoutManager.typesToShare
    }
    
    func getTypesToRead() -> Set<HKObjectType> {
        return workoutManager.typesToRead
    }
}
