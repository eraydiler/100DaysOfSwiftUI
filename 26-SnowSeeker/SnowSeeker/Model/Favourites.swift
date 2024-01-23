//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Eray Diler on 22.01.2024.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let store = FileStore(key: "Favourites")

    init() {
        resorts = store.fetcth() ?? []
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        store.set(value: resorts)
    }
}
