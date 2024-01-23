//
//  WatermarkModifier.swift
//  SnowSeeker
//
//  Created by Eray Diler on 23.01.2024.
//

import SwiftUI

struct WatermarkModifier: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .shadow(color: .black, radius: 5)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(WatermarkModifier(text: text))
    }
}
