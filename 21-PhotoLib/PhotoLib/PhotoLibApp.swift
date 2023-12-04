//
//  PhotoLibApp.swift
//  PhotoLib
//
//  Created by Eray Diler on 21.11.2023.
//

import SwiftUI

@main
struct PhotoLibApp: App {
    @StateObject var coreDataController = CoreDataController()

    var body: some Scene {
        WindowGroup {
            PhotoListView()
                .environment(
                    \.managedObjectContext,
                     coreDataController.container.viewContext
                )
        }
    }
}
