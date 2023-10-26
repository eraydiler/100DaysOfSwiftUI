//
//  ContentView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

/// Different ways of type erasure
struct TypeErasure: View {

    /// invalid code
//    var randomText: some View {
//        if Bool.random() {
//            return Text("Hello, World!")
//                .frame(width: 300)
//        } else {
//            return Text("Hello, World!")
//        }
//    }

    /// Most efficient compared to others
    /// There is just one view created
    var randomText1: some View {
        Text("Hello, World!")
            .frame(width: Bool.random() ? 300 : nil)
    }

    /// Wrapping in a group
    /// Two views are created
    var randomText2: some View {
        Group {
            if Bool.random() {
                Text("Hello, World!")
                    .frame(width: 300)
            } else {
                Text("Hello, World!")
            }
        }
    }

    /// Wrapping in a group
    @ViewBuilder
    var randomText3: some View {
        if Bool.random() {
            Text("Hello, World!")
                .frame(width: 300)
        } else {
            Text("Hello, World!")
        }
    }

    /// The last option to choose
    /// Because of its cost
    /// Two views are created
    var randomText4: some View {
        if Bool.random() {
            return AnyView(
                Text("Hello, World!")
                    .frame(width: 300)
            )
        } else {
            return AnyView(Text("Hello, World!"))
        }
    }

    var randomText5: some View {
        Text("Hello World")
            .font(.title)
            .erasedToAnyView()
    }

    var body: some View {
        randomText1
        randomText2
        randomText3
        randomText4
        randomText5
    }
}

extension View {
    func erasedToAnyView() -> AnyView {
        AnyView(self)
    }
}

#Preview {
    TypeErasure()
}
