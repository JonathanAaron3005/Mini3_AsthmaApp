//
//  ExerciseLocalEntity.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData

@Model
class ExerciseLocalEntity{
    @Attribute(.unique) var id: String
    let type: ExerciseType
    let isHavingSymptoms: Bool
    let symptomsLevel: Int
    
    init(id: String, type: ExerciseType, isHavingSymptoms: Bool, symptomsLevel: Int) {
        self.id = id
        self.type = type
        self.isHavingSymptoms = isHavingSymptoms
        self.symptomsLevel = symptomsLevel
    }
    
    func toDomain() -> ExerciseModel {
        return .init(
            id: self.id,
            type: self.type,
            isHavingSymptoms: self.isHavingSymptoms,
            symptomsLevel: self.symptomsLevel
        )
    }
}
