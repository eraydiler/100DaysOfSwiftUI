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

struct PhotoListView: View {
    @Environment(\.managedObjectContext) private var moc

    @State private var items: [PhotoListItem] = []
    @State private var presentingPhotoPickingFlow = false
    @State private var inputImage: UIImage?
    @State private var inputName: String = ""

    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink {
                    PhotoDetailView(image: Image(uiImage: item.image), name: item.name)
                } label: {
                    PhotoRow(item: item)
                }
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
            .onAppear(perform: loadData)
        }
    }
}

extension PhotoListView {
    private func loadData() {
        if !items.isEmpty { return }
        
        let request = Photo.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]

        do {
            let photos = try moc.fetch(request)
            for photo in photos {
                if let image = photo.getImage() {
                    items.append(PhotoListItem(image: image, name: photo.wrappedName))
                }
            }
        } catch {
            print("Fetch failed")
        }
    }

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
    let item: PhotoListItem

    var body: some View {
        HStack {
            Image(uiImage: item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.top, 10)
                .padding(.bottom, 10)

            Text(item.name)
                .padding(.leading)
        }
    }
}

fileprivate struct PhotoListItem: Identifiable {
    var id: String { name }
    var image: UIImage
    var name: String
}

#Preview {
    PhotoListView()
}
