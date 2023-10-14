//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Eray Diler on 13.10.2023.
//

import SwiftUI

struct ActivityDetailView: View {
    @Binding var activity: Activity
    @State var isSheetPresented = false

    var body: some View {
        ScrollView(.vertical) {
            Group {
                Text(activity.title)
                    .font(.title)
                Text(activity.description)
                    .font(.subheadline)
                    .padding(.top, 2)
                Text(activity.formattedNumberOfDescription)
                    .font(.caption)
                    .padding(.top, 10)
                    .foregroundStyle(activity.preferredColor)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
        .toolbar {
            Button("", systemImage: "pencil") {
                isSheetPresented = true
            }
            .padding(.top)
        }
        .sheet(isPresented: $isSheetPresented) {
            ActivityEditView(activity: $activity)
        }
    }
}

#Preview {
    @State var activity = Activity(
        title: "Activity1",
        description: "Desc1",
        numberOfCompletion: 0
    )

    return ActivityDetailView(activity: $activity)
}
