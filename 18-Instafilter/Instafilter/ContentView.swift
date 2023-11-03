//
//  ContentView.swift
//  Instafilter
//
//  Created by Eray Diler on 30.10.2023.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

/// Challenges
/// 1. Try making the Save button disabled if there is no image in the image view.
/// 2. Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
/// 3. Explore the range of available Core Image filters, and add any three of your choosing to the app.
///

struct ContentView: View {
    @State private var image: Image?
    @State private var processedImage: UIImage?
    @State private var filterIntensity: Double = 0.5
    @State private var filterRadius: Double = 0.5
    @State private var filterScale: Double = 0.5
    @State private var filterAngle: Double = 0.0
    @State private var filterAmount: Double = 0.0
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false

    private let context = CIContext()
    private var inputKeys: [String] { currentFilter.inputKeys }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundStyle(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture(perform: selectImage)

                VStack {
                    Text(currentFilter.name.replacingOccurrences(of: "CI", with: ""))
                    
                    if inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputAngleKey) {
                        HStack {
                            Text("Angle")
                            Slider(value: $filterAngle, in: 0...360)
                                .onChange(of: filterAngle, applyProcessing)
                        }
                    }
                    if inputKeys.contains(kCIInputAmountKey) {
                        HStack {
                            Text("Amount")
                            Slider(value: $filterAmount)
                                .onChange(of: filterAmount, applyProcessing)
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") { showingFilterSheet = true }
                    Spacer()
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.bottom, .horizontal])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage, loadImage)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(.crystallize()) }
                Button("Edges") { setFilter(.edges()) }
                Button("Gaussian Blur") { setFilter(.gaussianBlur()) }
                Button("Pixellate") { setFilter(.pixellate()) }
                Button("Sepia Tone") { setFilter(.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(.unsharpMask()) }
                Button("Vignette") { setFilter(.vignette()) }
                Button("Motion Blur") { setFilter(.motionBlur()) }
                Button("Vibrance") { setFilter(.vibrance()) }
                Button("Color Invert") { setFilter(.colorInvert()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

extension ContentView {
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    private func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()

        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.successHandler = {
            print("Success")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    private func selectImage() {
        showingImagePicker = true
    }

    private func applyProcessing() {
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { 
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputAngleKey) {
            currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey)
        }
        if inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(filterAmount, forKey: kCIInputAmountKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }

    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

#Preview {
    ContentView()
}
