//
//  PhotoPickerView.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import SwiftUI

struct PhotoPickerView: View {
    @Binding private var image: UIImage?
    @Binding private var location: Location?
    @Binding private var name: String
    @State private var isPresentedDestinationView = false
    private var didFinishFlow: () -> Void
    private var didCancel: () -> Void
    private let locationFetcher = LocationFetcher()

    init(
        image: Binding<UIImage?>,
        location: Binding<Location?>,
        name: Binding<String>,
        didFinishFlow: @escaping () -> Void,
        didCancel: @escaping () -> Void
    ) {
        _image = image
        _location = location
        _name = name
        self.didFinishFlow = didFinishFlow
        self.didCancel = didCancel
        locationFetcher.start()
    }

    var body: some View {
        NavigationStack {
            VStack {
                CameraImagePicker(
                    image: $image,
                    didFinishPicking: {
                        location = locationFetcher.lastKnownLocation
                        isPresentedDestinationView = true
                    },
                    didCancel: { didCancel() }
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Photo Picker")
                .navigationDestination(
                    isPresented: $isPresentedDestinationView,
                    destination: {
                        NameInputView(
                            inputName: $name,
                            didFinish: didFinishFlow
                        )
                    }
                )
            }
        }
    }
}
