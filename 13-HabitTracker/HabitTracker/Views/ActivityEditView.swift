//
//  ActivityEditView.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import SwiftUI

struct ActivityEditView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var activity: Activity

    var body: some View {
        NavigationStack {
            Form {
                Group {
                    TextField("", text: $activity.title)
                        .font(.title)
                    TextField("", text: $activity.description, axis: .vertical)
                        .font(.subheadline)
                    Stepper(
                        onIncrement: { changeNumberOfCompletion(by: 1) },
                        onDecrement: { changeNumberOfCompletion(by: -1) },
                        label: {
                            Text(activity.formattedNumberOfDescription)
                                .foregroundStyle(activity.preferredColor)
                                .font(.caption)
                        }
                    )
                }
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func changeNumberOfCompletion(by value: Int) {
        activity.numberOfCompletion = max(0, activity.numberOfCompletion + value)
    }
}

#Preview {
    @State var activity = Activity(
        title: "Activity",
        description: "Desc",
        numberOfCompletion: 0
    )
    
    return ActivityEditView(activity: $activity)
}
