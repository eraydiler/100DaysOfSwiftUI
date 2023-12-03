//
//  ContentView.swift
//  PhotoLib
//
//  Created by Eray Diler on 21.11.2023.
//

import SwiftUI

/**
 Helpful links
 https://medium.com/@ganeshrajugalla/swiftui-uiviewcontrollerrepresentable-4b74b4a672ff
*/

struct PhotoList: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var photos: FetchedResults<Photo>

    @State private var presentingPhotoPickingFlow = false
    @State private var inputImage: UIImage?
    @State private var inputName: String = ""

    var body: some View {
        NavigationStack {
            List(photos) { photo in
                PhotoRow(photo: photo)
            }
            .toolbar {
                Button("", systemImage: "plus") {
                    presentingPhotoPickingFlow = true
                }
            }
            .navigationTitle("Photos")
            .sheet(isPresented: $presentingPhotoPickingFlow) {
                PhotoPickerView(
                    inputImage: $inputImage,
                    inputName: $inputName,
                    didFinishFlow: {
                        presentingPhotoPickingFlow = false
                        savePhoto()
                        resetInputs()
                    },
                    didCancel: {
                        presentingPhotoPickingFlow = false
                    }
                )
            }
        }
    }
}

extension PhotoList {
    private func savePhoto() {
        guard let image = inputImage else {
            return
        }

        let filename = UUID()

        // Save image into file
        image.saveToFile(filename.uuidString)

        // Save photo into Core Data
        let photo = Photo(context: moc)
        photo.name = inputName
        photo.imageFilename = filename
        try? moc.save()
    }

    private func resetInputs() {
        inputName = ""
        inputImage = nil
    }
}

fileprivate struct PhotoRow: View {
    let photo: Photo

    var body: some View {
        HStack {
            if let filename = photo.imageFilename {
                let url = URL.documentsDirectory.appendingPathComponent(filename.uuidString)

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .failure(let error):
                        Text(error.localizedDescription)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    @unknown default:
                        fatalError("Unknown state")
                    }
                }
            }

            Text(photo.wrappedName)
                .padding(.leading)
        }
    }
}

#Preview {
    PhotoList()
}
