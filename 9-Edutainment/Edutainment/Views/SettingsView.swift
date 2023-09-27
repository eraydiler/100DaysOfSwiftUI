//
//  SettingsView.swift
//  Edutainment
//
//  Created by Eray Diler on 28.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var uptoValue: Int
    @Binding var numberOfQuestions: Int

    var body: some View {
        Section("Settings") {
            Group {
                Text("Multiplications from 2 up to \(uptoValue)")
                Picker("From 2 up to", selection: $uptoValue) {
                    ForEach(2...12, id: \.self) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                .font(.subheadline)

                Text("Number of questions \(numberOfQuestions)")
                Picker("From 2 up to", selection: $numberOfQuestions) {
                    ForEach(Array(stride(from: 5, through: 15, by: 5)), id: \.self) {
                        Text($0, format: .number)
                    }
                }
                .pickerStyle(.segmented)
                .font(.subheadline)
            }
            .font(.subheadline)
        }
    }
}

#Preview {
    @State var uptoValue = 12
    @State var numberOfQuestions = 5

    return SettingsView(uptoValue: $uptoValue, numberOfQuestions: $numberOfQuestions)
}
