//
//  TextEditors.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import SwiftUI

struct TextEditors: View {
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

#Preview {
    TextEditors()
}
