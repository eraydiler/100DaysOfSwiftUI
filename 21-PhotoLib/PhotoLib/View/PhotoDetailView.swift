//
//  PhotoDetailView.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import SwiftUI

struct PhotoDetailView: View {
    let image: Image
    let name: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.9)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .accessibilityHidden(true)

                    Text(name)
                        .font(.headline)
                        .padding(.top)
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)

        }
    }
}
