//
//  ManualPublishing.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SwiftUI

@MainActor fileprivate class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            // we can use here when we need to do sth before / while the object is updated.
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManualPublishingView: View {
    @StateObject fileprivate var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

#Preview {
    ManualPublishingView()
}
