//
//  LocalUserRepository.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData

internal protocol UserRepository {
    func fetch() -> UserModel
    func save(user: UserModel)
    func update(user: UserModel)
}

internal final class LocalUserRepository: UserRepository {
    private let container = SwiftDataContextManager.shared.container
    
    @MainActor func fetch() -> UserModel {
        do {
            let fetchDescriptor = FetchDescriptor<UserLocalEntity>()
            let user = try self.container?.mainContext.fetch(fetchDescriptor).first
            let model = user?.toDomain() ?? UserModel(id: UUID().uuidString, age: 21, HRmax: 199, isUsingInhaler: true, severityLevel: .mild, asthmaControl: .wellControlled)
            return model
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor func save(user: UserModel) {
        do {
            let user = UserLocalEntity(
                id: user.id,
                age: user.age,
                HRmax: user.HRmax,
                isUsingInhaler: user.isUsingInhaler,
                severityLevel: user.severityLevel,
                asthmaControl: user.asthmaControl
            )
            try self.container?.mainContext.insert(user)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor func update(user: UserModel) {
        do {
            let fetchDescriptor = FetchDescriptor<UserLocalEntity>()
            if let userFound = try self.container?.mainContext.fetch(fetchDescriptor).first {
                userFound.age = user.age
                userFound.HRmax = user.HRmax
                userFound.isUsingInhaler = user.isUsingInhaler
                userFound.severityLevel = user.severityLevel
                userFound.asthmaControl = user.asthmaControl
                try self.container?.mainContext.save()
            } else {
                print("update user data failed")
                return
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
