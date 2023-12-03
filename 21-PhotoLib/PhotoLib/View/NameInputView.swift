//
//  NameInputView.swift
//  PhotoLib
//
//  Created by Eray Diler on 3.12.2023.
//

import SwiftUI

struct NameInputView: View {
    @Binding private var inputName: String
    @State private var showingValidationAlert = false
    private var didFinish: () -> Void

    init(
        inputName: Binding<String>,
        didFinish: @escaping () -> Void
    ) {
        _inputName = inputName
        self.didFinish = didFinish
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("Pick a name for your photo", text: $inputName)
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                Button("Done", action: validate)
            }
            .alert("", isPresented: $showingValidationAlert) {
                Button("OK") {  }
            } message: {
                Text("Please enter a name")
            }
        }
    }

    private func validate() {
        guard !inputName.isEmpty else {
            showingValidationAlert = true
            return
        }

        didFinish()
    }
}
