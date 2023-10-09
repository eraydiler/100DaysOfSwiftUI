//
//  Archiving.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

fileprivate struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ArchivingView: View {
    @State private var user = User(firstName: "", lastName: "")

    var body: some View {
        VStack {
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Text("Your name is \(user.firstName) \(user.lastName).")
        }.onAppear() {
            getUser()
        }

        Button("Get User") {
            getUser()
        }

        Button("Save User") {
            saveUser()
        }
    }
}

extension ArchivingView {
    func getUser() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "UserData"),
           let user = try? decoder.decode(User.self, from: data) {
            self.user = user
        }
    }

    func saveUser() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(user) {
            UserDefaults.standard.set(data, forKey: "UserData")
        }
    }
}

#Preview {
    ArchivingView()
}
