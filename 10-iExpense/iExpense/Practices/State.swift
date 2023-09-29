//
//  State.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

extension StateView {
    private struct User {
        var firstName = "Bilbo"
        var lastName = "Baggins"
    }
}

struct StateView: View {
    @State private var user = User()

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
