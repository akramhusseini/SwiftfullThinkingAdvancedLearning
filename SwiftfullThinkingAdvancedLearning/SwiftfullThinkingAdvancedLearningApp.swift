//
//  SwiftfullThinkingAdvancedLearningApp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 03/06/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftfullThinkingAdvancedLearningApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UITestingBootcampView()
        }
        .modelContainer(sharedModelContainer)
    }
}
