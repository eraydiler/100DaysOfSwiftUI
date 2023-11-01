//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Eray Diler on 1.11.2023.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Save failed with error: \(error.localizedDescription)")
        } else {
            print("Save finished!")
        }
    }
}
