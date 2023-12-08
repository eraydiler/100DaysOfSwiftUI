//
//  ContentView.swift
//  PhotoLib
//
//  Created by Eray Diler on 21.11.2023.
//

import CoreData
import SwiftUI

/**
 Helpful links
 https://medium.com/@ganeshrajugalla/swiftui-uiviewcontrollerrepresentable-4b74b4a672ff
*/

struct PhotoListView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        PhotoDetailView(
                            image: Image(uiImage: item.image),
                            name: item.name,
                            location: item.location
                        )
                    } label: {
                        PhotoRow(item: item)
                    }
                }
                .onDelete() { offsets in viewModel.delete(at: offsets) }
            }
            .toolbar {
                if !viewModel.items.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        viewModel.presentingPhotoPickingFlow = true
                    }
                }
            }
            .navigationTitle("Photos")
            .sheet(isPresented: $viewModel.presentingPhotoPickingFlow) {
                PhotoPickerView(
                    image: $viewModel.inputImage,
                    location: $viewModel.location,
                    name: $viewModel.inputName,
                    didFinishFlow: {
                        viewModel.performPostPhotoPickingOperations()
                    },
                    didCancel: {
                        viewModel.presentingPhotoPickingFlow = false
                    }
                )
            }
            .onAppear() { viewModel.loadData() }
        }
    }
}

fileprivate extension PhotoListView {
    struct PhotoRow: View {
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
}

#Preview {
    @StateObject var coreDataController = CoreDataController()

    return PhotoListView(
        viewModel: PhotoListView.ViewModel(context: coreDataController.container.viewContext)
    )
}
