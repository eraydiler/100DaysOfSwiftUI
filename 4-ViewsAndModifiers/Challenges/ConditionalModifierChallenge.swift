//
//  Challenge2.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 11.09.2023.
//

import SwiftUI

struct ConditionalModifierChallenge: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    private var totalAmount: Double {
        return checkAmount + (Double(tipPercentage) / 100 * checkAmount)
    }

    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return FloatingPointFormatStyle<Double>.Currency(code: "USD", locale: Locale.current)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalAmount, format: currencyFormatter)
                        .background(tipPercentage == 0 ? Color.red : Color.white)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    ConditionalModifierChallenge()
}
