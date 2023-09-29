//
//  State.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

fileprivate class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct StateObjectView: View {
    @StateObject private var user = User()

    var body: some View {
        StateObjectInnerView(user: user)
    }
}

struct StateObjectInnerView: View {
    @ObservedObject fileprivate var user: User

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

#Preview {
    StateView()
}
