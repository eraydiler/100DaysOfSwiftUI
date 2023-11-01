//
//  WrappingUIViewControllers.swift
//  Instafilter
//
//  Created by Eray Diler on 31.10.2023.
//

import SwiftUI

struct WrappingUIViewControllers: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }

            Button("Save Image") {
                saveImage()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { loadImage() }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    func saveImage() {
        guard let inputImage = inputImage else { return }

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

#Preview {
    WrappingUIViewControllers()
}

