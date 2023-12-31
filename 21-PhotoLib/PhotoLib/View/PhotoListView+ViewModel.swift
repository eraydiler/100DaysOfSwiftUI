//
//  PhotoListView+ViewModel.swift
//  PhotoLib
//
//  Created by Eray Diler on 5.12.2023.
//

import CoreData
import UIKit

extension PhotoListView {
    @MainActor
    class ViewModel: NSObject, ObservableObject {
        @Published private(set) var items: [PhotoListItem] = []
        @Published var presentingPhotoPickingFlow = false
        @Published var inputImage: UIImage?
        @Published var location: Location?
        @Published var inputName: String = ""

        private let fetchedResultsController: NSFetchedResultsController<Photo>

        let moc: NSManagedObjectContext

        init(context: NSManagedObjectContext) {
            let request = Photo.fetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]

            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            self.moc = context
            super.init()

            fetchedResultsController.delegate = self

            do {
                try fetchedResultsController.performFetch()
            } catch {
                print("Fetch failed")
            }

            updateItems()
        }

        private func savePhoto() {
            guard let image = inputImage else {
                return
            }

            let filename = UUID()

            // Save image into file
            FileManager.default.saveImage(image, intoFile: filename.uuidString)

            // Save photo into Core Data
            let photo = Photo(context: moc)
            photo.name = inputName
            photo.imageFilename = filename
            if let latitude = location?.latitude, let longitude = location?.longitude {
                photo.latitude = latitude
                photo.longitude = longitude
            }
            try? moc.save()
        }

        func loadData() {
            if !items.isEmpty { return }

            let request = Photo.fetchRequest()
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]

            do {
                let photos = try moc.fetch(request)
                for photo in photos {
                    let filename = photo.imageFilename?.uuidString
                    if let image = FileManager.default.getImage(fromFile: filename) {
                        items.append(PhotoListItem(image: image, name: photo.wrappedName))
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }

        func delete(at offsets: IndexSet) {
            let photos = fetchedResultsController.fetchedObjects ?? []
            for offset in offsets {
                let photo = photos[offset]
                // Delete image in disc
                FileManager.default.deleteFile(photo.imageFilename?.uuidString)
                // Delete photo in Core Data
                moc.delete(photo)
                try? moc.save()
            }
        }
        
        func performPostPhotoPickingOperations() {
            presentingPhotoPickingFlow = false
            savePhoto()
            resetInputs()
        }

        private func updateItems() {
            items = fetchedResultsController
                .fetchedObjects?
                .compactMap { photo in
                    let filename = photo.imageFilename?.uuidString
                    guard let image = FileManager.default.getImage(fromFile: filename) else {
                        return nil
                    }
                    return PhotoListItem(image: image, name: photo.wrappedName, location: photo.location)
                } ?? []
        }

        private func resetInputs() {
            inputName = ""
            inputImage = nil
        }
    }
}

extension PhotoListView.ViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == fetchedResultsController {
            updateItems()
        }
    }
}
