//
//  ContentView.swift
//  HotProspects
//
//  Created by Eray Diler on 9.12.2023.
//

import SwiftUI

/**

 ### Challenge

 1. Add an icon to the “Everyone” screen showing whether a prospect was contacted or not.

 2. Use JSON and the documents directory for saving and loading our user data.

 3. Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent.

 */

struct TabContentView: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

#Preview {
    TabContentView()
}
