//
//  DiceRollerApp.swift
//  DiceRoller
//
//  Created by Eray Diler on 11.01.2024.
//

import SwiftUI

@main
struct DiceRollerApp: App {
    @AppStorage("numberOfItems")
    private var numberOfItems = 6
    @AppStorage("numberOfSides")
    private var numberOfSides = 6

    var body: some Scene {
        WindowGroup {
            ContentView(numberOfItems: $numberOfItems, numberOfSides: $numberOfSides)
        }
    }
}
