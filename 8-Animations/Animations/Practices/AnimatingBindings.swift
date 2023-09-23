//
//  AnimatingBindings.swift
//  Animations
//
//  Created by Eray Diler on 21.09.2023.
//

import SwiftUI

struct AnimatingBindings: View {
    @State private var animationAmount = 1.0

    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()
            Button("Tap Me") { }
                .padding(50)
                .foregroundColor(.white)
                .background(.red)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
        }
    }
}

#Preview {
    AnimatingBindings()
}
