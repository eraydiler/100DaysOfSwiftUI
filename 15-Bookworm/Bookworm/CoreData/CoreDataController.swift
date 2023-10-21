//
//  CoreDataController.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import CoreData
import Foundation

class CoreDataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

extension CoreDataController {
    static var previewTestBook: Book {
        let book = Book(context: CoreDataController().container.viewContext)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        book.creationDate = Date.now
        return book
    }
}
