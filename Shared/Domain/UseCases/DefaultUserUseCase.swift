//
//  DefaultUserUseCase.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation

internal protocol UserUseCase {
    func saveUser(dob: Date, severity: SeverityLevel?, totalScore: Int?, isUsingInhaler: Bool, HRMax: Double?)
    func calculateActScore(totalScore: Int) -> ACTScore?
    func calculateHRMax(age: Int) -> Double
}

internal final class DefaultUserUseCase: UserUseCase {
    private let userRepo: UserRepository
    
    init(userRepo: LocalUserRepository) {
        self.userRepo = userRepo
    }
    
    func saveUser(dob: Date, severity: SeverityLevel?, totalScore: Int?, isUsingInhaler: Bool, HRMax: Double?) {
        var actScore: ACTScore?
        let age = dob.age()
        let finalHRMax: Double
        
        if let totalScore = totalScore {
            actScore = calculateActScore(totalScore: totalScore)
        }
        
        if let HRMax = HRMax {
            finalHRMax = HRMax
        } else {
            finalHRMax = calculateHRMax(age: age)
        }
        
        let userModel = UserModel(id: UUID().uuidString, age: age, HRmax: finalHRMax, isUsingInhaler: isUsingInhaler, severityLevel: severity, asthmaControl: actScore)
        
        userRepo.save(user: userModel)
    }
    
    func calculateActScore(totalScore: Int) -> ACTScore? {
        if totalScore <= 15 {
            return .veryPoorlyControlled
        } else if totalScore <= 20 {
            return .poorlyControlled
        } else if totalScore <= 25 {
            return .wellControlled
        }
        
        return nil
    }
    
    func calculateHRMax(age: Int) -> Double {
        return 208 - 0.7 * Double(age)
    }
}
