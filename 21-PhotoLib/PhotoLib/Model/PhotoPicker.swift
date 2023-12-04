//
//  PhotoPicker.swift
//  PhotoLib
//
//  Created by Eray Diler on 21.11.2023.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    private var didFinishPicking: () -> ()
    private var didCancel: () -> ()

    init(
        image: Binding<UIImage?>,
        didFinishPicking: @escaping () -> Void,
        didCancel: @escaping () -> Void
    ) {
        _image = image
        self.didFinishPicking = didFinishPicking
        self.didCancel = didCancel
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

extension ImagePicker {
    class Coordinator: PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Cancel
            if results.isEmpty {
                self.parent.didCancel()
                return
            }

            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { 
                return
            }

            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                        self.parent.didFinishPicking()
                    }
                }
            }
        }
    }
}
