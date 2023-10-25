//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Eray Diler on 23.10.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var coreDataController = PracticesCoreDataController()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            DynamicFiltering()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
