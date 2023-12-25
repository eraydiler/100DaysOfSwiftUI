//
//  Card.swift
//  Flashzilla
//
//  Created by Eray Diler on 20.12.2023.
//

import Foundation

class Card: Identifiable, Codable {
    var id = UUID()
    let prompt: String
    let answer: String
    private(set) var creationDate = Date()

    init(prompt: String, answer: String) {
        self.prompt = prompt
        self.answer = answer
    }

    static let example = Card(
        prompt: "Who played the 13th Doctor in Doctor Who?",
        answer: "Jodie Whittaker"
    )
}

@MainActor class CardStack: ObservableObject {
    @Published private(set) var cards: [Card]
    private let store = FileStore(key: "CardStack")

    init() {
        cards = store.fetcth() ?? []
    }

    func add(_ card: Card) {
        cards.append(card)
        save()
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }

    private func save() {
        store.set(value: cards)
    }
}
