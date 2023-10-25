//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Eray Diler on 25.10.2023.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

}

extension Candy : Identifiable {
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
