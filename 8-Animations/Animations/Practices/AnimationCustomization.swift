//
//  AnimationCustomization.swift
//  Animations
//
//  Created by Eray Diler on 21.09.2023.
//

import SwiftUI

struct AnimationCustomization: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button ("Tap Me") {
        }
        .padding (50)
        .background(.red)
        .foregroundColor (.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

#Preview {
    AnimationCustomization()
}
