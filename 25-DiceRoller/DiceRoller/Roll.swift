//
//  Roll.swift
//  DiceRoller
//
//  Created by Eray Diler on 19.01.2024.
//

import Foundation

struct Roll: Codable, Identifiable {
    var id = UUID()
    let dices: [Dice]
    let sides: Int
    let total: Int
}

@MainActor class RollCollection: ObservableObject {
    @Published private(set) var items: [Roll]
    private var store = FileStore(key: "Rolls")

    init() {
        items = store.fetcth() ?? []
    }

    func add(_ roll: Roll) {
        items.insert(roll, at: 0)
        save()
    }

    private func save() {
        store.set(value: items)
    }
}
