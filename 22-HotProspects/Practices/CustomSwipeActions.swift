//
//  CustomSwipeActions.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SwiftUI

struct CustomSwipeActionsView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }    }
}

#Preview {
    CustomSwipeActionsView()
}
