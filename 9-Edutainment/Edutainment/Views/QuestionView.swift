//
//  QuestionView.swift
//  Edutainment
//
//  Created by Eray Diler on 28.09.2023.
//

import SwiftUI

struct QuestionView: View {
    @Binding var questions: [Question]
    @Binding var questionNumber: Int
    @Binding var userAnswer: Int?

    var body: some View {
        Group {
            Section("Question \(questionNumber + 1)") {
                Text("\(questions[questionNumber].text)")
                TextField("Your Answer", value: $userAnswer, format: .number)
                    .keyboardType(.numberPad)
            }
        }
        .font(.subheadline)
    }
}
