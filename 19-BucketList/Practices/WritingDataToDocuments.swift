//
//  WritingDataToDocuments.swift
//  BucketList
//
//  Created by Eray Diler on 6.11.2023.
//

import SwiftUI

struct WritingDataToDocuments: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                let str = "Test Message"
                let url = URL.documentsDirectory.appendingPathComponent("message.txt")

                do {
                    /// Atomic writing causes the system to write our full file to a temporary filename
                    /// (not the one we asked for), and when that’s finished it does a simple rename
                    /// to our target filename. This means either the whole file is there or nothing is.
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    WritingDataToDocuments()
}

/// back in project 8 we looked at how to create a generic extension on Bundle that let us find, 
/// load, and decode any Codable data from our app bundle. Can you write something similar
/// for the documents directory, perhaps making it an extension on FileManager?
extension FileManager {
    func decode<T: Codable>(_ file: String) -> T {
        let url = URL.documentsDirectory.appendingPathComponent("message.txt")

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
