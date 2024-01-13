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

    @ObservedObject private var collection: DiceCollection = DiceCollection(
        numberOfItems: 2,
        numberOfSides: 6
    )

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    ForEach(0..<collection.items.count, id: \.self) { index in
                        let dice = collection.items[index]

                        VStack {
                            Text("Dice-\(index + 1)")
                                .font(.largeTitle)
                            Text("\(dice.topSide)")
                                .font(.title)
                        }
                    }
                }
                Spacer()
                Button("Roll", action: restart)
                    .font(.largeTitle)
            }
            .onReceive(timer) { time in
                if timeRemaining > 0 {
                    collection.rollAll()
                    timeRemaining -= 1
                } else {
                    timerSubscription?.cancel()
                }
            }
            .toolbar {
                NavigationLink{
                    SettingsView(
                        numberOfItems: $collection.numberOfItems,
                        numberOfSides: $collection.numberOfSides
                    )
                } label: {
                    Label("", systemImage: "gear")
                }
            }
            .onChange(of: collection.numberOfItems, update)
            .onChange(of: collection.numberOfSides, update)
        }
    }

    private func update() {
        print("Change: ")
        print("Number Of Items: \(collection.numberOfItems)")
        print("Number Of Sides: \(collection.numberOfSides)")
    }

    private func restart() {
        timeRemaining = 10
        timer = Timer.publish(every: 0.05, on: .main, in: .common)
        timerSubscription = timer.connect()
    }
}

#Preview {
    ContentView()
}
