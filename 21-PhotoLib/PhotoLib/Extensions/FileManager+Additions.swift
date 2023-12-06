//
//  UIImage+Additions.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import UIKit

extension FileManager {
    func getImage(fromFile filename: String?) -> UIImage? {
        guard let filename = filename else {
            return nil
        }

        let fileURL = URL.documentsDirectory.appendingPathComponent(filename)

        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
            return nil
        }
    }

    func saveImage(_ image: UIImage, intoFile filename: String) {
        let url = URL.documentsDirectory.appendingPathComponent(filename)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
        }
    }

    func deleteFile(_ filename: String?) {
        guard let filename = filename else { return }
        let url = URL.documentsDirectory.appendingPathComponent(filename)

        do {
            try removeItem(at: url)
        } catch let error {
            print("Could not delete image: \(error.localizedDescription)")
        }
    }
}

extension FileManager {
    func decode<T: Codable>(_ file: String) -> T {
        let url = URL.documentsDirectory.appendingPathComponent(file)

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

