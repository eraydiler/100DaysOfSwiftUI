//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Eray Diler on 3.12.2023.
//
//

import Foundation
import CoreData


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
