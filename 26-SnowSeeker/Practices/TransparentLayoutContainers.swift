//
//  TransparentLayoutContainers.swift
//  SnowSeeker
//
//  Created by Eray Diler on 20.01.2024.
//

import SwiftUI

struct TransparentLayoutContainers: View {
    private let notes = "Using groups as transparent layout containers"

    private var exampleViews: [AnyView] = [
        AnyView(Example1()),
        AnyView(Example2())
    ]

    var body: some View {
        Text(notes)
            .modifier(ExamplesViewModifier(exampleViews: exampleViews))
    }
}

fileprivate extension TransparentLayoutContainers {
    struct UserView: View {
        var body: some View {
            Group {
                Text("Name: Paul")
                Text("Country: England")
                Text("Pets: Luna and Arya")
            }
            .font(.title)
        }
    }

    struct Example1: View {
        @State private var layoutVertically = false

            var body: some View {
                Group {
                    if layoutVertically {
                        VStack {
                            UserView()
                        }
                    } else {
                        HStack {
                            UserView()
                        }
                    }
                }
                .onTapGesture {
                    layoutVertically.toggle()
                }
            }
    }

    struct Example2: View {
        @Environment(\.horizontalSizeClass) var sizeClass

        var body: some View {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

#Preview {
    TransparentLayoutContainers()
}
