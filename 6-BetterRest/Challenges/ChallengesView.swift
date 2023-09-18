//
//  1.swift
//  BetterRest
//
//  Created by Eray Diler on 18.09.2023.
//

/*

  https://www.hackingwithswift.com/books/ios-swiftui/betterrest-wrap-up

  1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
  2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
  3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.

 */

import Foundation
import CoreML
import SwiftUI

struct ChallengesView: View {
    @State private var wakeUpTime = Calendar.current.date(from: DateComponents(hour: 8, minute: 0)) ?? Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    private var predictedSleepTime: String {
        return calculate()
    }

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    DatePicker(
                        "Select your wake up time",
                        selection: $wakeUpTime,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                }

                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amnount of sleep")
                }

                Section {
                    Picker("\(coffeeAmount.formatted()) cups", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }

                Section {
                    Text(predictedSleepTime)
                } header: {
                    Text("Your ideal bedtime is")
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    private func calculate() -> String {
        let calculator = BedtimeCalculator()
        
        do {
            let predictedSleepTime = try calculator.getPredictedSleepTimeFrom(
                wakeUpTime: wakeUpTime,
                sleepAmount: sleepAmount,
                coffeeAmount: coffeeAmount
            )
            return predictedSleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return error.localizedDescription
        }
    }
}

#Preview {
    ChallengesView()
}

