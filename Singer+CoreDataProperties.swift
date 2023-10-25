//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Eray Diler on 25.10.2023.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}

extension Singer : Identifiable {
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}
