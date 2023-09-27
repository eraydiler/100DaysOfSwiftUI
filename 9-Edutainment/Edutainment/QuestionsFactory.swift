//
//  QuestionsFactory.swift
//  Edutainment
//
//  Created by Eray Diler on 27.09.2023.
//

import Foundation

struct QuestionFactory {
    let numberOfQuestions: Int
    var uptoValue: Int

    func prepareQuestions() -> [Question] {
        var newQuestions: [Question] = []

        for _ in 1...numberOfQuestions {
            newQuestions.append(
                Question(
                    firstNumber: Int.random(in: 2...uptoValue),
                    secondNumber: Int.random(in: 2...uptoValue)
                )
            )
        }

        return newQuestions
    }
}
