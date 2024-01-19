//
//  ContentView.swift
//  DiceRoller
//
//  Created by Eray Diler on 11.01.2024.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State var timeRemaining = 10
    @State private var timer = Timer.publish(
        every: 0.05,
        tolerance: nil,
        on: .main,
        in: .common
    )
    @State private var timerSubscription: Cancellable?
    @ObservedObject private var rollCollection = RollCollection()
    @ObservedObject private var diceCollection: DiceCollection 
    @State private var isFirstRollMade = false

    @Binding private var numberOfItems: Int
    @Binding private var numberOfSides: Int

    init(numberOfItems: Binding<Int>, numberOfSides: Binding<Int>) {
        _numberOfItems = numberOfItems
        _numberOfSides = numberOfSides
        _diceCollection = ObservedObject(
            initialValue: DiceCollection(
                numberOfItems: numberOfItems.wrappedValue,
                numberOfSides: numberOfSides.wrappedValue
            )
        )
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                HStack {
                    ForEach(0..<diceCollection.items.count, id: \.self) { index in
                        let dice = diceCollection.items[index]

                        VStack {
                            Text("🎲")
                                .font(.title3)
                                .bold()
                            Text(isFirstRollMade ? "\(dice.topSide)" : "-")
                                .font(.headline)
                        }
                    }
                }

                VStack {
                    Text("∑")
                        .font(.title2)
                        .bold()
                    Text(timeRemaining == 0 ? (isFirstRollMade ? "\(diceCollection.total)" : "-") : "-")
                        .font(.title3)
                }.padding()

                Section(rollCollection.items.isEmpty ? "" : "Previous rolls") {
                    List(rollCollection.items) { roll in
                        HStack {
                            VStack {
                                Text("S")
                                Text(roll.sides, format: .number)
                            }
                            Spacer()
                            ForEach(0..<roll.dices.count, id: \.self) { index in
                                let dice = roll.dices[index]

                                VStack {
                                    Text("🎲")
                                    Text(dice.topSide, format: .number)
                                }
                            }
                            Spacer()
                            VStack {
                                Text("∑")
                                Text(roll.total, format: .number)
                            }
                        }
                        .font(.caption2)
                    }
                }
                .scrollIndicators(.hidden)

                Button("Roll", action: restartTimer)
                    .font(.title)
            }
            .sensoryFeedback(.selection, trigger: timeRemaining > 0)
            .onReceive(timer) { time in
                if timeRemaining > 0 {
                    roll()
                    timeRemaining -= 1
                } else {
                    timerSubscription?.cancel()
                    saveRoll()
                }
            }
            .toolbar {
                NavigationLink{
                    SettingsView(
                        numberOfItems: $diceCollection.numberOfItems,
                        numberOfSides: $diceCollection.numberOfSides
                    )
                } label: {
                    Label("", systemImage: "gear")
                }
            }
            .onChange(of: diceCollection.numberOfItems, settingsDidUpdate)
            .onChange(of: diceCollection.numberOfSides, settingsDidUpdate)
        }
    }


    private func roll() {
        diceCollection.rollAll()
    }
    
    private func saveRoll() {
        let roll = Roll(
            dices: diceCollection.items,
            sides: diceCollection.numberOfSides,
            total: diceCollection.total
        )
        rollCollection.add(roll)
    }

    private func settingsDidUpdate() {
        isFirstRollMade = false
        numberOfItems = diceCollection.numberOfItems
        numberOfSides = diceCollection.numberOfSides
        print("Settings update")
        print("Number Of Items: \(diceCollection.numberOfItems)")
        print("Number Of Sides: \(diceCollection.numberOfSides)")
    }

    private func restartTimer() {
        isFirstRollMade = true
        timeRemaining = 10
        timer = Timer.publish(every: 0.05, on: .main, in: .common)
        timerSubscription = timer.connect()
    }
}

#Preview {
    ContentView(
        numberOfItems: Binding.constant(6),
        numberOfSides: Binding.constant(6)
    )
}
