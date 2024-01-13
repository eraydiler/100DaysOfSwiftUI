//
//  Dice.swift
//  DiceRoller
//
//  Created by Eray Diler on 13.01.2024.
//

import Foundation

struct Dice {
    let sides: [Int]
    private(set) var topSide: Int

    init(numberOfSides: Int) {
        topSide = Int.random(in: 1...numberOfSides)
        self.sides = Array(1...numberOfSides)
    }

    mutating func roll() {
        topSide = Int.random(in: 1...sides.count)
    }
}

@MainActor class DiceCollection: ObservableObject {
    @Published private(set) var items: [Dice] = []
    @Published var numberOfItems: Int { didSet { reset() }}
    @Published var numberOfSides: Int { didSet { reset() }}

    init(numberOfItems: Int, numberOfSides: Int) {
        self.numberOfItems = numberOfItems
        self.numberOfSides = numberOfSides
        reset()
    }

    private func reset() {
        if !items.isEmpty {
            items.removeAll()
        }

        for _ in 1...numberOfItems {
            let dice = Dice(numberOfSides: numberOfSides)
            self.items.append(dice)
        }
    }

    func rollAll() {
        objectWillChange.send()

        for i in 0..<items.count {
            items[i].roll()
        }
    }
}
