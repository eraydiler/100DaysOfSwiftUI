//
//  SpecificAccessibilitySupport.swift
//  Flashzilla
//
//  Created by Eray Diler on 19.12.2023.
//

import SwiftUI

fileprivate struct DifferentiateWithoutColorView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

fileprivate struct ReduceMotionView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0

    // The whole throws/rethrows thing is more advanced Swift, but it’s a direct copy of
    // the function signature for withAnimation() so that the two can be used interchangeably.
    private func withOptionalAnimation<Result>(
        _ animation: Animation? = .default,
        _ body: () throws -> Result
    ) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
    }
}

fileprivate struct ReduceTransparencyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct SpecificAccessibilitySupport: View {
    var body: some View {
        VStack {
            ReduceMotionView()
            DifferentiateWithoutColorView()
            ReduceTransparencyView()
        }
    }
}

#Preview {
    SpecificAccessibilitySupport()
}
