//
//  Maps_introApp.swift
//  Maps-intro
//
//  Created by Natalie S on 2025-05-05.
//

import SwiftUI

@main
struct Maps_introApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
