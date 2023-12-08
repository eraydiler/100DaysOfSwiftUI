//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Eray Diler on 7.12.2023.
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
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Photo {
    var wrappedName: String { name ?? "No name"}
    var location: Location {
        Location(latitude: latitude, longitude: longitude)
    }
}
