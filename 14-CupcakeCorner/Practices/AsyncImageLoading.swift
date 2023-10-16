//
//  AsyncImageLoading.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 16.10.2023.
//

import SwiftUI

struct AsyncImageLoading: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .failure(let error):
                Text(error.localizedDescription)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            @unknown default:
                fatalError("Unknown state")
            }
        }
    }
}

#Preview {
    AsyncImageLoading()
}
