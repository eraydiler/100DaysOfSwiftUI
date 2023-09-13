//
//  ContentView.swift
//  Milestone-Projects1-3
//
//  Created by Eray Diler on 11.09.2023.
//

/*
  Day23-24: Milestone: Projects 1-3
  https://www.hackingwithswift.com/100/swiftui/25
*/

import SwiftUI

struct ContentView: View {
    @State private var pickedIndex = Int.random(in: 0...2)
    @State private var moves = [
        Move(type: .rock, color: .brown),
        Move(type: .paper, color: .orange),
        Move(type: .scissors, color: .yellow)
    ]

    @State private var score = 0
    @State private var shouldWin = Bool.random()
    @State private var numberOfQuestionAsked = 1

    @State private var isGameOver = false

    private var pickedMove: Move {
        moves[pickedIndex]
    }

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack {
                Text("\(shouldWin ? "Win" : "Lose")")
                    .foregroundColor(shouldWin ? .green : .red)
                Text("for")
                Text(pickedMove.emoji)
            }
            .font(.system(size: 20, weight: .semibold))

            Spacer()
            ForEach(moves, id: \.title) { move in
                Button {
                    handle(userMove: move)
                    nextMove()
                } label: {
                    MoveView(move: move)
                }
            }
            Spacer()
            Spacer()
            Spacer()
            Group {
                Text("Score: \(score)")
                Text("Question: \(numberOfQuestionAsked)")
            }.font(.system(size: 20, weight: .semibold))
        }
        .padding()
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("You finished the game with score \(score)")
        }
    }
}

extension ContentView {
    private func handle(userMove: Move) {
        print("*********")
        print("Should " + (shouldWin ? "Win" : "Lose"))
        print("App picked: \(moves[pickedIndex])")
        print("User picked: \(userMove)")

        let correct = {
            print("Correct!")
            score += 1
        }

        let incorrect = {
            print("False!")
            score -= 1
        }

        switch userMove.beats(pickedMove) {
        case true:
            if shouldWin {
                correct()
            } else {
                incorrect()
            }
        case false:
            if !shouldWin {
                correct()
            } else {
                incorrect()
            }
        }
    }

    private func nextMove() {
        if numberOfQuestionAsked == 10 {
            isGameOver = true
        } else {
            pickedIndex = Int.random(in: 0...2)
            shouldWin.toggle()
            numberOfQuestionAsked += 1
        }
    }

    private func reset() {
        score = 0
        pickedIndex = Int.random(in: 0...2)
        shouldWin.toggle()
        numberOfQuestionAsked = 1
    }
}

#Preview {
    ContentView()
}
