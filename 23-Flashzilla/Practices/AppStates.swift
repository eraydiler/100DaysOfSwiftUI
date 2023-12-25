//
//  AppStates.swift
//  Flashzilla
//
//  Created by Eray Diler on 19.12.2023.
//

import SwiftUI

struct AppStatesView: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

#Preview {
    AppStatesView()
}
