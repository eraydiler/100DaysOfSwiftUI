//
//  ContentView.swift
//  WordScramble
//
//  Created by Eray Diler on 18.09.2023.
//

/*
 Day29-31: Project 5
 https://www.hackingwithswift.com/100/swiftui/(29...31)
 */

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var usedWords = [String]()

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("new word", text: $newWord)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                }
                Section {
                    ForEach(usedWords, id: \.self) {
                        Text($0)
                    }
                }
            }
            .alert(
                errorTitle,
                isPresented: $showError,
                actions: {
                    Button("OK", role: .cancel, action: { } )
                },
                message: {
                    Text(errorMessage)
                }
            )

            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .onSubmit(addNewWord)
            .submitLabel(.done)
        }
    }
}

extension ContentView {
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

    private func addNewWord() {
        guard !isUsedBefore() else {
            showError(title: "Used word", message: "You already used \(newWord)")
            return
        }

        guard isNotMisspelling() else {
            showError(title: "Misspelling word", message: "You can't just make them up, you know!")
            return
        }

        guard isValid() else {
            showError(title: "Invalid Word", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        withAnimation {
            usedWords.append(newWord.lowercased())
        }
        newWord = ""
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
    ContentView()
}
