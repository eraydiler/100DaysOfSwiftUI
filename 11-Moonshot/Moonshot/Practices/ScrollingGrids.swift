//
//  ScrollingGrids.swift
//  Moonshot
//
//  Created by Eray Diler on 2.10.2023.
//

import SwiftUI

let fixedLayout = [
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80))
]

let adaptiveLayout = [
    GridItem(.adaptive(minimum: 80, maximum: 120))
]

struct ScrollingGrids: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveLayout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

#Preview {
    ScrollingGrids()
}
