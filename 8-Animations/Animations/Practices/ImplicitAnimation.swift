//
//  ScaleEffectView.swift
//  Animations
//
//  Created by Eray Diler on 21.09.2023.
//

import SwiftUI

struct ImplicitAnimationView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button ("Tap Me") {
            animationAmount += 1
        }
        .padding (50)
        .background(.red)
        .foregroundColor (.white)
        .clipShape(Circle ( ))
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 2)
        .animation(.default, value: animationAmount)
    }
}

#Preview {
    ImplicitAnimationView()
}
