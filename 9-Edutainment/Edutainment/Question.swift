//
//  Question.swift
//  Edutainment
//
//  Created by Eray Diler on 27.09.2023.
//

import Foundation

struct Question {
    var text: String { "What is \(firstNumber) x \(secondNumber)" }
    var answer: Int { firstNumber * secondNumber }
    let firstNumber: Int
    let secondNumber: Int
}
