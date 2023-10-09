//
//  VisibilityTransitions.swift
//  Animations
//
//  Created by Eray Diler on 22.09.2023.
//

import SwiftUI

struct VisibilityTransitions: View {
    @State private var isShowing = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowing.toggle()
                }
            }

            if isShowing {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    VisibilityTransitions()
}
