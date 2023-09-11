//
//  CustomModifier.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 11.09.2023.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct CustomModifier: View {
    var body: some View {
        Text("Title")
            .titleStyle() //.modifier(Title())
        Text("Content")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .watermarked(with: "by Eray")
    }
}

#Preview {
    CustomModifier()
}
