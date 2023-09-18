//
//  ContentView.swift
//  UnitConverter
//
//  Created by Eray Diler on 31.08.2023.
//

/*
  Day19: Challenge 1
  https://www.hackingwithswift.com/100/swiftui/19
*/

import SwiftUI

struct ContentView: View {
    @State private var value = "0.0"
    @State private var selectedUnitTypeIndex = 0
    @State private var selectedFromUnitIndex = 0
    @State private var selectedToUnitIndex = 0

    private var unitTypes: [any UnitType] = [Temperature(), Length(), Time(), Volume()]

    private var fromUnitName: String {
        unitTypes[selectedUnitTypeIndex].units[selectedFromUnitIndex].name
    }

    private var toUnitName: String {
        unitTypes[selectedUnitTypeIndex].units[selectedToUnitIndex].name
    }

    private var convertedValue: Double {
        let fromUnit = unitTypes[selectedUnitTypeIndex].units[selectedFromUnitIndex].unit
        let toUnit = unitTypes[selectedUnitTypeIndex].units[selectedToUnitIndex].unit
        return Measurement(value: Double(value) ?? 0.0, unit: fromUnit).converted(to: toUnit).value
    }

    @FocusState private var amountIsFocused: Bool

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
                Picker("Type", selection: $selectedUnitTypeIndex) {
                    ForEach(0 ..< unitTypes.count, id: \.self) {
                        Text(unitTypes[$0].name)
                    }
                }
                .pickerStyle(.navigationLink)

                Section {
                    Picker("From", selection: $selectedFromUnitIndex) {
                        ForEach(0 ..< unitTypes[selectedUnitTypeIndex].units.count, id: \.self) {
                            Text(unitTypes[selectedUnitTypeIndex].units[$0].name)
                        }
                    }
                    .pickerStyle(.navigationLink)

                    Picker("To", selection: $selectedToUnitIndex) {
                        ForEach(0 ..< unitTypes[selectedUnitTypeIndex].units.count, id: \.self) {
                            Text(unitTypes[selectedUnitTypeIndex].units[$0].name)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section {
                    HStack {
                        TextField("", text: $value)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        Text(fromUnitName)
                    }
                    HStack {
                        Spacer()
                        Text("=")
                    }
                    HStack {
                        Spacer()
                        Text(String(convertedValue))
                        Text(toUnitName)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
