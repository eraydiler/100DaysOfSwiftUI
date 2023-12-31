//
//  CoreDataController.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import CoreData
import Foundation

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "Practices")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
