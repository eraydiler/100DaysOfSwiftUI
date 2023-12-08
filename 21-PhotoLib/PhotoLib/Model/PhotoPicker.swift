//
//  PhotoPicker.swift
//  PhotoLib
//
//  Created by Eray Diler on 21.11.2023.
//

import MobileCoreServices
import PhotosUI
import SwiftUI

struct CameraImagePicker: UIViewControllerRepresentable {
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

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

extension CameraImagePicker {
    class Coordinator: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        var parent: CameraImagePicker

        init(parent: CameraImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            guard
                let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
                mediaType == UTType.image.identifier,
                let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                print("Failed to pick image")
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.image = image
                self.parent.didFinishPicking()
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.didCancel()
        }
    }
}
