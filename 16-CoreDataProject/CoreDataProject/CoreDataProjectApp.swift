//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Eray Diler on 23.10.2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var coreDataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            Challenges()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
