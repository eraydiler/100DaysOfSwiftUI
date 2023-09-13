//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eray Diler on 5.09.2023.
//

import SwiftUI

/*
  Day20-22: Project 2
  https://www.hackingwithswift.com/100/swiftui/22
*/

struct ContentView: View {
    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertMessage = ""
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0

    @State private var numberOfQuestionAsked = 1
    @State private var showingGameOverAlert = false
    @State private var gameOverAlertTitle = ""
    @State private var gameOverAlertMessage = ""

    private let maximumNumberOfQuestions = 8
    private var isGameOver: Bool { numberOfQuestionAsked >= maximumNumberOfQuestions }

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Group {
                    Text("Question: \(numberOfQuestionAsked)")
                    let _ = print(numberOfQuestionAsked)
                    Text("Score: \(score)")
                }
                .foregroundColor(.white)
                .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreAlertTitle, isPresented: $showingScoreAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreAlertMessage)
        }
        .alert(gameOverAlertTitle, isPresented: $showingGameOverAlert) {
            Button("Restart", action: reset)
        } message: {
            Text(gameOverAlertMessage)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
        } else {
            score -= 1
        }

        if isGameOver {
            showGameOverAlert()
        } else {
            showScoreAlert(number)
        }
    }

    private func showGameOverAlert() {
        gameOverAlertTitle = "Finish!"
        gameOverAlertMessage = "Your score is \(score)"
        showingGameOverAlert = true
    }

    private func showScoreAlert(_ number: Int) {
        if number == correctAnswer {
            scoreAlertTitle = "Correct!"
            scoreAlertMessage = "Your score is \(score)"
        } else {
            scoreAlertTitle = "Wrong!"
            scoreAlertMessage = "That’s the flag of \(countries[number])"
        }
        
        showingScoreAlert = true
    }

    private func reset() {
        numberOfQuestionAsked = 0
        score = 0
        askQuestion()
    }

    private func askQuestion() {
//        if isGameOver {
//            reset()
//        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            numberOfQuestionAsked += 1
//        }
    }
}

#Preview {
    ContentView()
}
