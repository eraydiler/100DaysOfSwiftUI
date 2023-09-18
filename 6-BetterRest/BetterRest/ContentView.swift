//
//  ContentView.swift
//  BetterRest
//
//  Created by Eray Diler on 13.09.2023.
//

/*
  Day26-28: Project 4
  https://www.hackingwithswift.com/100/swiftui/28
*/

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Calendar.current.date(from: DateComponents(hour: 8, minute: 0)) ?? Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var predictedSleepTime = Date.now
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker(
                        "Select your wake up time",
                        selection: $wakeUpTime,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                }
                
                VStack(alignment: .leading) {
                    Text("Desired amnount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading) {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Stepper("\(coffeeAmount.formatted()) cups", value: $coffeeAmount, in: 1...20)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculate)
            }
            .alert(
                alertTitle,
                isPresented: $showAlert,
                actions: {
                    Button("Done") { }
                }, message: {
                    Text(alertMessage)
                }
            )
        }
    }

    private func calculate() {
        let calculator = BedtimeCalculator()

        do {
            predictedSleepTime = try calculator.getPredictedSleepTimeFrom(
                wakeUpTime: wakeUpTime,
                sleepAmount: sleepAmount,
                coffeeAmount: coffeeAmount
            )
            alertTitle = "Your ideal bedtime is"
            alertMessage = "\(predictedSleepTime.formatted(date: .omitted, time: .shortened))"
            showAlert = true
        } catch {
            alertTitle = "Error"
            alertMessage = "\(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
