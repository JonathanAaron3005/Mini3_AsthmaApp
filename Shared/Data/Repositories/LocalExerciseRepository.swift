//
//  ExerciseRepository.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData
import HealthKit

internal protocol ExerciseRepository {
    func fetch() -> [ExerciseModel]
    func fetch(by exerciseType: ExerciseType) -> [ExerciseModel]
    func save(exercise: ExerciseModel)
    func delete(id: String)
}

internal final class LocalExerciseRepository: ExerciseRepository {
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor func fetch() -> [ExerciseModel] {
        do{
            let fetchDescriptor = FetchDescriptor<ExerciseLocalEntity>()
            let exercises = try self.container?.mainContext.fetch(fetchDescriptor)
            let models = exercises?.compactMap{ $0.toDomain() } ?? []
            return models
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor func fetch(by exerciseType: ExerciseType) -> [ExerciseModel] {
        do {
            let fetchDescriptor = FetchDescriptor<ExerciseLocalEntity>(
                predicate: #Predicate { entity in
                    entity.type == exerciseType
                }
            )
            let exercises = try container?.mainContext.fetch(fetchDescriptor)
            let models = exercises?.compactMap{ $0.toDomain() } ?? []
            return models
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor func save(exercise: ExerciseModel) {
        do {
            let newExercise = ExerciseLocalEntity(
                id: exercise.id,
                type: exercise.type,
                isHavingSymptoms: exercise.isHavingSymptoms,
                symptomsLevel: exercise.symptomsLevel
            )
            
            try self.container?.mainContext.insert(newExercise)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor func delete(id: String) {
        do {
            let fetchDescriptor = FetchDescriptor<ExerciseLocalEntity>(
                predicate: #Predicate { entity in
                    entity.id == id
                }
            )
            if let noteToDelete = try container?.mainContext.fetch(fetchDescriptor).first {
                container?.mainContext.delete(noteToDelete)
                try container?.mainContext.save()
            } else {
                throw NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Note not found"])
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
