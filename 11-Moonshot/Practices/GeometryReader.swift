//
//  ContentView.swift
//  Moonshot
//
//  Created by Eray Diler on 1.10.2023.
//

import SwiftUI

struct ImageViews: View {
    var body: some View {
        GeometryReader { geo in
        Image("img-example")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width * 0.8)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    ImageViews()
}
