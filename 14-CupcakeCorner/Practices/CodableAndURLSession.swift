//
//  CodableAndURLSession.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 16.10.2023.
//

import SwiftUI

fileprivate struct Response: Codable {
    var results: [Result]
}

fileprivate struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct CodableAndURLSession: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }

    private func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=richie+kotzen&entity=song") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data + \(error)")
        }
    }
}

#Preview {
    CodableAndURLSession()
}
