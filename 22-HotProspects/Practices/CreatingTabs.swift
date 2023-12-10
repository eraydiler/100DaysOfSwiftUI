//
//  CreatingTabs.swift
//  HotProspects
//
//  Created by Eray Diler on 9.12.2023.
//

import SwiftUI

struct CreatingTabsView: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
//                .onTapGesture {
//                    selectedTab = "Two"
//                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
//                .tag("One")

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
//                .tag("Two")
        }
    }
}

#Preview {
    CreatingTabsView()
}
