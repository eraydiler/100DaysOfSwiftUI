//
//  PhotoPickerView.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import SwiftUI

struct PhotoPickerView: View {
    @Binding private var inputImage: UIImage?
    @Binding private var inputName: String
    @State private var isPresentedDestinationView = false
    private var didFinishFlow: () -> Void
    private var didCancel: () -> Void

    init(
        inputImage: Binding<UIImage?>,
        inputName: Binding<String>,
        didFinishFlow: @escaping () -> Void,
        didCancel: @escaping () -> Void
    ) {
        _inputImage = inputImage
        _inputName = inputName
        self.didFinishFlow = didFinishFlow
        self.didCancel = didCancel
    }

    var body: some View {
        NavigationStack {
            VStack {
                ImagePicker(
                    image: $inputImage,
                    didFinishPicking: { isPresentedDestinationView = true },
                    didCancel: { didCancel() }
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Photo Picker")
                .navigationDestination(
                    isPresented: $isPresentedDestinationView,
                    destination: {
                        NameInputView(
                            inputName: $inputName,
                            didFinish: didFinishFlow
                        )
                    }
                )
            }
        }
    }
}
