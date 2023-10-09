//
//  PushingViews.swift
//  Moonshot
//
//  Created by Eray Diler on 2.10.2023.
//

import SwiftUI

struct PushingViews: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("Main")
        }
    }
}

#Preview {
    PushingViews()
}
