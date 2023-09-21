//
//  ListsView.swift
//  WordScramble
//
//  Created by Eray Diler on 19.09.2023.
//

import SwiftUI

struct ListView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    ListView()
}
