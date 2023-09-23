//
//  ContentView.swift
//  Animations
//
//  Created by Eray Diler on 21.09.2023.
//

import SwiftUI

/*

  Day32-34: Project 6 - Challenge
  https://www.hackingwithswift.com/100/swiftui/(32...34)

  1. When you tap a flag, make it spin around 360 degrees on the Y axis.
  2. Make the other two buttons fade out to 25% opacity.
  3. Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? 
     Or flip in a different direction? Experiment!

*/

struct SpinModifier: ViewModifier {
    let amount: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(amount),
                axis: (x: 0, y: 1, z: 0)
            )
    }
}

func asyncAfter(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

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

    @State private var rotationAngles = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var scales = [1.0, 1.0, 1.0]

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

                    ForEach(0..<3) { index in
                        Button {
                            withAnimation(.interactiveSpring(duration: 0.5, extraBounce: 0.3)) {
                                rotationAngles[index] = 360
                                opacities[index] = 1.0
                                scales[index] = 1.0

                                for otherIndex in 0..<3 where otherIndex != index {
                                    rotationAngles[otherIndex] = 0
                                    opacities[otherIndex] = 0.5
                                    scales[otherIndex] = 0.95
                                }
                            } completion: {
                                asyncAfter(0.5) {
                                    flagTapped(index)
                                }
                            }
                        } label: {
                            Image(countries[index])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .opacity(opacities[index])
                        .rotation3DEffect(
                            Angle(degrees: rotationAngles[index]),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .scaleEffect(scales[index])
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
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestionAsked += 1

        for i in 0...2 {
            rotationAngles[i] = 0
            opacities[i] = 1.0
            scales[i] = 1.0
        }
    }
}

#Preview {
    ContentView()
}
