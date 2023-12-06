//
//  CoreDataController.swift
//  PhotoLib
//
//  Created by Eray Diler on 2.12.2023.
//

import CoreData

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "PhotoLib")

    init() {
        print(NSHomeDirectory())
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
