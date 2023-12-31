//
//  ContentView.swift
//  Edutainment
//
//  Created by Eray Diler on 26.09.2023.
//

import SwiftUI

/*
 Day35: Milestone: Projects 4-6
 https://www.hackingwithswift.com/100/swiftui/35
 */

struct ContentView: View {
    private struct InitialValue {
        static let numberOfQuestions = 5
        static let uptoValue = 10
    }

    @State private var questionsDidPrepared: Bool = false
    @State private var uptoValue = InitialValue.uptoValue
    @State private var numberOfQuestions = InitialValue.numberOfQuestions
    @State private var questionNumber = 0
    @State var questions: [Question] = []
    @State var userAnswer: Int?
    @State var score = 0
    @State private var showingGameOverAlert = false
    @State private var gameOverAlertTitle = ""
    @State private var gameOverAlertMessage = ""

    private var isLastQuestion: Bool { questionNumber == numberOfQuestions - 1 }

    var body: some View {
        Form {
            if questionsDidPrepared {
                SettingsView(
                    uptoValue: $uptoValue,
                    numberOfQuestions: $numberOfQuestions
                )
                QuestionView(
                    questions: $questions,
                    questionNumber: $questionNumber,
                    userAnswer: $userAnswer
                )
                SubmitView(userAnswer: $userAnswer) {
                    askQuestion()
                }
            }
        }
        .font(.headline)
        .listRowSeparator(.hidden)
        .onChange(of: uptoValue) { oldValue,newValue in startNewGame() }
        .onChange(of: numberOfQuestions) { oldValue,newValue in startNewGame() }
        .onAppear(perform: startNewGame)
        .alert(gameOverAlertTitle, isPresented: $showingGameOverAlert) {
            Button("Restart", action: startNewGame)
        } message: {
            Text(gameOverAlertMessage)
        }
        .overlay {
            if !questionsDidPrepared {
                ContentUnavailableView {
                    Label("No Data", systemImage: "tray.fill")
                } description: {
                    Text("Game failed to start due to missing data")
                }
            }
        }
    }
}

extension ContentView {
    private func startNewGame() {
        questionNumber = 0
        score = 0
        userAnswer = nil
        prepareNewQuestions()
        logGameStats()
        questionsDidPrepared = true
    }

    private func logGameStats() {
        print("New Game Started with the questions: ")
        questions.enumerated().forEach { index, question in
            print("\(index) ) \(question.text) = \(question.answer)")
        }
        print("Question number is \(questionNumber)")
        print()
    }

    private func prepareNewQuestions() {
        questions = QuestionFactory(
            numberOfQuestions: InitialValue.numberOfQuestions,
            uptoValue: InitialValue.uptoValue
        ).prepareQuestions()
    }

    private func askQuestion() {
        if userAnswer == questions[questionNumber].answer {
            score += 1
        } else {
            score -= 1
        }

        if isLastQuestion {
            showGameOverAlert()
        } else {
            questionNumber += 1
        }

        userAnswer = nil
    }

    private func showGameOverAlert() {
        gameOverAlertTitle = "Finish!"
        gameOverAlertMessage = "Your score is \(score)"
        showingGameOverAlert = true
    }
}

#Preview {
    ContentView()
}
