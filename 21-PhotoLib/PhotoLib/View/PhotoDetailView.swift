//
//  PhotoDetailView.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import MapKit
import SwiftUI

struct PhotoDetailView: View {
    let image: Image
    let name: String
    let location: Location?

    var body: some View {
        NavigationStack {
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

                        if let location = location, location.isAvailable {
                            NavigationLink {
                                LocationDetailView(location: location)
                            } label: {
                                Text("Location")
                            }
                        }
                    }
                    .padding([.horizontal, .vertical])
                }
                .multilineTextAlignment(.center)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
