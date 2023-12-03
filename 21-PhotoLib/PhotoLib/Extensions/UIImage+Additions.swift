//
//  UIImage+Additions.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import UIKit

extension UIImage {
    func saveToFile(_ filename: String) {
        let url = URL.documentsDirectory.appendingPathComponent(filename)

        if let jpegData = self.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
        }
    }
}
