//
//  ChallengesView.swift
//  WordScramble
//
//  Created by Eray Diler on 20.09.2023.
//

import SwiftUI

/*

 https://www.hackingwithswift.com/books/ios-swiftui/word-scramble-wrap-up

 1. Disallow answers that are shorter than three letters or are just our start word.
 2. Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
 3. Put a text view somewhere so you can track and show the player’s score for a given root word.
    How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

 */

struct ChallengesView: View {
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords = [String]()

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false

    private var score: Int {
        return usedWords.reduce(0) { $0 + $1.count + 1 }
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("new word", text: $newWord)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                } header: {
                    HStack {
                        Spacer()
                        Text("Score: ")
                        Text(score, format: .number)
                    }
                }
                Section {
                    ForEach(usedWords, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart", action: restartGame)
            }
            .onAppear(perform: startGame)
            .onSubmit(addNewWord)
            .submitLabel(.done)
            .alert(errorTitle, isPresented: $showError) {
                Button("OK", role: .cancel, action: { } )
            } message: {
                Text(errorMessage)
            }
        }
    }
}

extension ChallengesView {
    private func startGame() {
        guard
            let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let words = try? String(contentsOf: fileURL)
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: "\n"),
            let word = words.randomElement()?.lowercased()
        else {
            fatalError("Fail while splitting start.txt file")
        }

        rootWord = word
    }

    private func restartGame() {
        startGame()
        newWord = ""
        usedWords.removeAll()
    }

    private func addNewWord() {
        guard isNotRootWord() else {
            showError(title: "Same word!", message: "The word must be different from the start word!")
            return
        }

        guard isLongEnough() else {
            showError(title: "Short word!", message: "The word must have at least 3 letters!")
            return
        }

        guard !isUsedBefore() else {
            showError(title: "Used word!", message: "You already used \(newWord)!")
            return
        }

        guard isNotMisspelling() else {
            showError(title: "Misspelling word!", message: "You can't just make them up, you know!")
            return
        }

        guard isValid() else {
            showError(title: "Invalid word!", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        withAnimation {
            usedWords.append(newWord.lowercased())
        }
        newWord = ""
    }

    private func isNotRootWord() -> Bool {
        return newWord != rootWord
    }

    private func isLongEnough() -> Bool {
        return newWord.count >= 3
    }

    private func isUsedBefore() -> Bool {
        return usedWords.contains(newWord)
    }

    private func isNotMisspelling() -> Bool {
        let checker = UITextChecker()
        let mispellingRange = checker.rangeOfMisspelledWord(
            in: newWord,
            range: NSRange(location: 0, length: newWord.utf16.count),
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return mispellingRange.location == NSNotFound
    }

    private func isValid() -> Bool {
        var tempWord = rootWord

        for letter in newWord {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }

        return true
    }

    private func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

#Preview {
    ChallengesView()
}
