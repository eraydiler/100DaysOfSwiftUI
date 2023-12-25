//
//  CardStackEditView.swift
//  Flashzilla
//
//  Created by Eray Diler on 23.12.2023.
//

import SwiftUI

struct CardStackEditView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var cardStack: CardStack

    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("New card") {
                    TextField("Enter new card's question", text: $newPrompt)
                    TextField("Enter new card's answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }

                Section(!cardStack.cards.isEmpty ? "All Cards" : "") {
                    ForEach(cardStack.cards) { card in
                        VStack {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done", systemImage: "done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(prompt: newPrompt, answer: newAnswer)
        cardStack.add(card)
    }

    func removeCards(at offsets: IndexSet) {
        cardStack.removeCards(at: offsets)
    }
}

#Preview(traits: .landscapeLeft) {
    @StateObject var stack = CardStack()
    return CardStackEditView(cardStack: stack)
}
