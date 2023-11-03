//
//  ContentView.swift
//  Instafilter
//
//  Created by Eray Diler on 30.10.2023.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var processedImage: UIImage?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false

    private let context = CIContext()

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

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") { showingFilterSheet = true }
                    Spacer()
                    Button("Save", action: save)
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
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { 
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return  }

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
