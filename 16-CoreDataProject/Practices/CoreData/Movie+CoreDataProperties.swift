//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Eray Diler on 23.10.2023.
//
//

import Foundation
import CoreData

///
/// .xcdataModel -> CodeGen -> Manual/None
/// .xcdataModel -> Menu -> Editor -> Create NSManaged Object Subclass
///
extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}
