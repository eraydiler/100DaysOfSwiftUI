//
//  ActivityList.swift
//  HabitTracker
//
//  Created by Eray Diler on 13.10.2023.
//

import SwiftUI

struct ActivityList: View {
    @ObservedObject
    private var store: ActivityStore = {
        let store = ActivityStore()
//        store.clear()
//        store.items = Activity.generateMockedItems(20)
        return store
    }()

    @State var isSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach($store.items) { $item in
                    NavigationLink {
                        ActivityDetailView(activity: $item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description)
                                .font(.footnote)
                            Text(item.formattedNumberOfDescription)
                                .font(.caption)
                                .foregroundStyle(item.preferredColor)
                        }
                    }
                }
                .onDelete(perform: remove)
                .listRowSeparator(.hidden)
                .navigationTitle("Activities")
            }
            .toolbar {
                Button("", systemImage: "plus") {
                    isSheetPresented = true
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                ActivityAdditionView(store: store)
            }
        }
    }

    private func remove(atOffsets offsets: IndexSet) {
        store.remove(atOffsets: offsets)
    }
}

#Preview {
    ActivityList()
}
