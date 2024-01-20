//
//  ExamplesViewModifier.swift
//  SnowSeeker
//
//  Created by Eray Diler on 20.01.2024.
//

import SwiftUI

struct ExamplesViewModifier: ViewModifier {
    let exampleViews: [AnyView]

    func body(content: Content) -> some View {
        NavigationStack {
            List {
                content
                    .padding(.bottom)
                    .listRowBackground(Color.clear)
                ForEach(0..<exampleViews.count, id: \.self) { index in
                    let view = exampleViews[index]

                    NavigationLink {
                        view
                    } label: {
                        Text("Example \(index + 1)")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
