//
//  ViewModifierChallenge.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 11.09.2023.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitle() -> some View {
        return self.modifier(ProminentTitle())
    }
}

struct ViewModifierChallenge: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .prominentTitle()
    }
}

#Preview {
    ViewModifierChallenge()
}
