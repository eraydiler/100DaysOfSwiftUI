//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Eray Diler on 22.01.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
