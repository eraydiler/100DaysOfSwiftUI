//
//  EnvironmentObjects.swift
//  HotProspects
//
//  Created by Eray Diler on 9.12.2023.
//

import SwiftUI

@MainActor fileprivate class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject fileprivate var user: User

    var body: some View {
        TextField("Name", text: $user.name)
            .multilineTextAlignment(.center)
    }
}

struct DisplayView: View {
    @EnvironmentObject fileprivate var user: User

    var body: some View {
        Text(user.name)
    }
}

struct EnvironmentObjectsView: View {
    @StateObject private var user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

#Preview {
    EnvironmentObjectsView()
}
