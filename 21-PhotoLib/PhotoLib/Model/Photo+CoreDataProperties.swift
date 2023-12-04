//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Eray Diler on 3.12.2023.
//
//

import Foundation
import CoreData
import UIKit


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var imageFilename: UUID?
    @NSManaged public var name: String?

}

extension Photo: Identifiable {
}

extension Photo {
    var wrappedName: String { name ?? "No name"}
}

extension Photo {
    func getImage() -> UIImage? {
        guard let fileName = imageFilename?.uuidString else {
            return nil
        }

        let fileURL = URL.documentsDirectory.appendingPathComponent(fileName)

        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
            return nil
        }
    }
}
