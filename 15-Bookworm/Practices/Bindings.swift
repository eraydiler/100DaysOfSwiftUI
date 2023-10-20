//
//  Bindings.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import SwiftUI

fileprivate struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: isOn ? onColors : offColors),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct Bindings: View {
    @State private var isOn = false

    var body: some View {
        VStack {
            PushButton(title: "Push", isOn: $isOn)
            Text(isOn ? "On" : "Off")
        }
        .padding()
    }
}

#Preview {
    Bindings()
}
