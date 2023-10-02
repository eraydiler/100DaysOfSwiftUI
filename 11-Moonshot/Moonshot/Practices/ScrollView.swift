//
//  ScrollView.swift
//  Moonshot
//
//  Created by Eray Diler on 1.10.2023.
//

import SwiftUI

struct CustomText: View {
    let text: String

    init(_ text: String) {
        print("Creating \(text)")
        self.text = text
    }

    var body: some View {
        Text(text)
    }
}

/// Note: LazyVStack / LazyHStack are better to use int this case.
/// They don't create all the views at once, but when they needed.
struct ScrollViews: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
//            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ScrollViews()
}
