//
//  FileManager+Codable.swift
//  HotProspects
//
//  Created by Eray Diler on 16.12.2023.
//

import Foundation

extension FileManager {
    private var dateFormat: String { "y-MM-dd" }

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    func decode<T: Codable>(from file: String) -> T? {
        let url = URL.documentsDirectory.appendingPathComponent(file)

        guard fileExists(atPath: url.path()) else {
            print("File not exist at \(url)")
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to convert data from \(url)")
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode data into json \(error)")
        }
    }

    func encode<T: Codable>(value: T, into file: String) {
        let url = URL.documentsDirectory.appendingPathComponent(file)

        do {
            let data = try encoder.encode(value)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
}
