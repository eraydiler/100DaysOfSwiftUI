//
//  AnimatingGestures.swift
//  Animations
//
//  Created by Eray Diler on 21.09.2023.
//

import SwiftUI

struct AnimatingGestures: View {
    private let letters = Array("Hello, SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { index in
                Text(String(letters[index]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(
                        .default.delay(Double(index) / 20),
                        value: dragAmount
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged {
                    dragAmount = $0.translation
                }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    AnimatingGestures()
}
