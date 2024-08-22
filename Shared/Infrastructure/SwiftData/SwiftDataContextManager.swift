//
//  SwiftDataContextManager.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 15/08/24.
//

import Foundation
import SwiftData

class SwiftDataContextManager{
    public static var shared = SwiftDataContextManager()
    var container: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            container = try ModelContainer(for: ExerciseLocalEntity.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}

