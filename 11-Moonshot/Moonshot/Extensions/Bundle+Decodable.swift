//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Eray Diler on 3.10.2023.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file)")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to convert data from \(url)")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode data into json \(error)")
        }
    }
}
