//
//  UserDefaults.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

struct UserDefaultsView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    UserDefaultsView()
}
