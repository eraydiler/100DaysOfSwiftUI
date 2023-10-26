//
//  ContentView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

struct UserListView: View {
    @State var users: [User] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    if user.isActive {
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            UserRow(user: user)
                        }
                    } else {
                        UserRow(user: user)
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear { Task { await fetchUsers() } }
        }
    }
}

extension UserListView {
    private func fetchUsers() async {
        guard users.isEmpty else { return }

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid data + \(error)")
        }
    }
}

fileprivate struct UserRow: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(user.name)
                    .font(.headline)
                Text(user.company)
                    .font(.subheadline)
            }
            .foregroundStyle( user.isActive ? .black : .gray )
        }
    }
}

#Preview {
    UserListView()
}
