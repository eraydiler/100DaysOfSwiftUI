//
//  CapsuleText.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 11.09.2023.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ViewComposition: View {
      var body:some View {
          VStack(spacing: 10) {
              CapsuleText(text: "First")
                  .foregroundColor(.white)
              CapsuleText(text: "Second")
                  .foregroundColor(.yellow)
          }
    }
}

#Preview {
    ViewComposition()
}
