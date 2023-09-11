//
//  Challenge3.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 11.09.2023.
//

import SwiftUI

struct FlagImageView: View {
    var countryName: String

    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImageChallenge: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"
    ].shuffled()

    var body: some View {
        VStack {
            ForEach(0..<3) { number in
                Button {
                } label: {
                    FlagImageView(countryName: countries[number])
                }
            }
        }
    }
}

#Preview {
    FlagImageChallenge()
}
