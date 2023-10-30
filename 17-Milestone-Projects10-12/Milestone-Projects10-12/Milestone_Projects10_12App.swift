//
//  Milestone_Projects10_12App.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

@main
struct Milestone_Projects10_12App: App {
    @StateObject private var coreDataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            UserListView()
                .environment(
                    \.managedObjectContext,
                     coreDataController.container.viewContext
                )
        }
    }
}
