//
//  CoreDataController.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 27.10.2023.
//

import CoreData
import Foundation

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataModel")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }

    func clearData(for entityNames: [String]) {
        for entityName in entityNames {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let context = container.viewContext
            
            do {
                try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
            } catch {
                print(error)
            }
        }
    }
}
