//
//  ContextMenus.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SwiftUI

/**
     1. If you’re going to use them, use them in lots of places –    it can be frustrating to press and hold on something only    to find nothing happens.
     2. Keep your list of options as short as you can – aim for      three or less.
     3. Don’t repeat options the user can already see elsewhere      in your UI.

    Remember, context menus are by their nature hidden, so please think twice before hiding important actions in a context menu.
 */
struct ContextMenus: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    ContextMenus()
}
