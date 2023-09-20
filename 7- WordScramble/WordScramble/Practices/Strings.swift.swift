//
//  Bundles.swift
//  WordScramble
//
//  Created by Eray Diler on 19.09.2023.
//

import SwiftUI

struct StringsView: View {
    var body: some View {
        Text(check("Swift") ? "All Good" : "Incorrect spelling!")
            .font(.largeTitle)
    }

    private func check(_ word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        let allGood = misspelledRange.location == NSNotFound

        return allGood
    }
}

#Preview {
    StringsView()
}
