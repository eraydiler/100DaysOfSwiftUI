//
//  SubmitView.swift
//  Edutainment
//
//  Created by Eray Diler on 28.09.2023.
//

import SwiftUI

struct SubmitView: View {
    @Binding var userAnswer: Int?
    private var submitButtonDidTap: () -> ()

    init(userAnswer: Binding<Int?>, action: @escaping () -> ()) {
        _userAnswer = userAnswer
        self.submitButtonDidTap = action
    }

    var body: some View {
        HStack {
            Spacer()
            Button("Submit") {
                submitButtonDidTap()
            }
            .foregroundColor(userAnswer == nil ? .gray : .orange)
            .disabled(userAnswer == nil)
            Spacer()
        }
    }
}
