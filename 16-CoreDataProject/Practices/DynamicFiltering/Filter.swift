//
//  Filter.swift
//  CoreDataProject
//
//  Created by Eray Diler on 25.10.2023.
//

import Foundation

struct Filter: Hashable {
    var title: String
    var predicate: NSPredicate?
}

extension Filter {
    static let examples: [Filter] = {
        [
            Filter(title: "none", predicate: nil),
            Filter(title: "universe == 'Star Wars'", predicate: NSPredicate(format: "universe == 'Star Wars'")),
            Filter(title: "universe == 'Star Trek'", predicate: NSPredicate(format: "universe == %@", "Star Trek")),
            Filter(title: "Name < F", predicate: NSPredicate(format: "name < %@", "F")),
            Filter(title: "Universe In ['Aliens', 'Firefly', 'Star Trek']]", predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])),
            Filter(title: "Begins with E", predicate: NSPredicate(format: "name BEGINSWITH %@", "E")),
            Filter(title: "Begins with e", predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")),
            Filter(title: "Begins with e (case-insensitive)", predicate: NSPredicate(format: "name BEGINSWITH[C] %@", "e")),
            Filter(title: "Not begins with e", predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
        ]
    }()
}
