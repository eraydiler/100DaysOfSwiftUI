//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var coreDataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
