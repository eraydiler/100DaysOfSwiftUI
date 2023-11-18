//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Eray Diler on 16.11.2023.
//

import SwiftUI

/**

 ### Challenge

 1. The check out view in Cupcake Corner uses an image and loading spinner
    that don’t add anything to the UI, so find a way to make the screenreader not read them out.

 2. Fix the list rows in iExpense so they read out the name and value in one
    single VoiceOver label, and their type in a hint.

 3. Do a full accessibility review of Moonshot – what changes do you
    need to make so that it’s fully accessible?

 */

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
