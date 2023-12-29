//
//  AbsolutePositioning.swift
//  LayoutAndGeometry
//
//  Created by Eray Diler on 28.12.2023.
//

import SwiftUI

struct AbsolutePositioningView: View {
    var body: some View {
        ScrollView {
            Group {
                Text("1. Hello, World!")
                    .position(x: 100, y: 100)
                    .border(Color.black)

                Text("2. Hello, world!")
                    .background(.red)
                    .position(x: 100, y: 100)
                    .border(Color.black)

                Text("3. Hello, world!")
                    .position(x: 100, y: 100)
                    .background(.red)
                    .border(Color.black)

                Text("4. Hello, world!")
                    .offset(x: 100, y: 100)
                    .background(.red)
                    .border(Color.black)
            }
            .frame(height: 500)
        }
    }
}

#Preview {
    AbsolutePositioningView()
}
