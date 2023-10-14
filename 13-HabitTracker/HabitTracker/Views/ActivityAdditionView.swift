//
//  ActivityAdditionView.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import SwiftUI

struct ActivityAdditionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: ActivityStore
    @State var title: String = ""
    @State var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    save()
                    dismiss()
                }
            }
        }
    }

    private func save() {
        let activity = Activity(
            title: title,
            description: description,
            numberOfCompletion: 0
        )
        
        store.add(item: activity)
    }
}

#Preview {
    let store: ActivityStore = ActivityStore()
    return ActivityAdditionView(store: store)
}
