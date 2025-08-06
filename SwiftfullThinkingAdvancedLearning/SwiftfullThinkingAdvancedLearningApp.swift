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
    
    let currentUserSignedIn: Bool
    
    init() {
//        let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn")
//        let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
//        let userIsSignedIn: Bool = value == "true" ? true : false
        self.currentUserSignedIn = userIsSignedIn
    }
    
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
            UITestingBootcampView(currentUserIsSignedin: currentUserSignedIn)
        }
        .modelContainer(sharedModelContainer)
    }
}
