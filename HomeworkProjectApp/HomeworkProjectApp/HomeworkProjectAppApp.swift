//
//  HomeworkProjectAppApp.swift
//  HomeworkProjectApp
//
//  Created by Arturs Sosnars on 29/08/2025.
//

import SwiftUI
import SwiftData
import HomeworkDataModels

@main
struct HomeworkProjectAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pokemon.self
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootView: View {
    @Environment(\.modelContext) var context
    @State private var isFetcherReady = false

    var body: some View {
        Group {
            if isFetcherReady {
                ContentView()
            } else {
                ProgressView("Initializing...")
            }
        }
        .task {
            isFetcherReady = true
        }
    }
}
