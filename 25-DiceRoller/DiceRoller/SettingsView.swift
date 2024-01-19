//
//  SettingsView.swift
//  DiceRoller
//
//  Created by Eray Diler on 13.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var numberOfItems: Int
    @Binding var numberOfSides: Int

    var body: some View {
        Form {
            Picker("Number of dices", selection: $numberOfItems) {
                ForEach(1...6, id: \.self) {
                    Text($0, format: .number)
                }
            }
            Picker("Number of sides", selection: $numberOfSides) {
                ForEach([4, 6, 8, 10, 12, 20, 100], id: \.self) {
                    Text($0, format: .number)
                }
            }
        }
    }
}
