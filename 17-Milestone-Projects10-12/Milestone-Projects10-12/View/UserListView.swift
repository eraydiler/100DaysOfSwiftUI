//
//  ContentView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import CoreData
import SwiftUI

struct UserListView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) private var cachedUsers: FetchedResults<CachedUser>
    @State private var loading = false
    @State private var isViewFirstAppeared = true

    var body: some View {
        NavigationStack {
            ContentView(cachedUsers: cachedUsers, loading: loading)
                .navigationTitle("Users")
                .onAppear { Task { await fetchUsers() } }
                .onDisappear { isViewFirstAppeared = false }
        }
    }

    private struct ContentView: View {
        let cachedUsers: FetchedResults<CachedUser>
        let loading: Bool

        var body: some View {
            if loading {
                ProgressView()
            } else {
                List {
                    ForEach(cachedUsers) { user in
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
            }
        }
    }
}

extension UserListView {
    private func fetchUsers() async {
        guard isViewFirstAppeared else { return }
        loading = true

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            await cacheUsers(decodedUsers)
        } catch {
            print("Invalid data + \(error)")
        }
    }

    private func cacheUsers(_ users: [User]) async {
        await MainActor.run {
            users.forEach { user in
                do {
                    let _ = try CachedUser(user: user, insertInto: moc)
                    try moc.save()
                } catch {
                    print("Failed to cache user: \(error.localizedDescription)")
                }
            }

            loading = false
        }
    }
}

fileprivate struct UserRow: View {
    let user: CachedUser

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(user.wrappedName)
                    .font(.headline)
                Text(user.wrappedCompany)
                    .font(.subheadline)
            }
            .foregroundStyle( user.isActive ? .black : .gray )
        }
    }
}

#Preview {
    @StateObject var coreDataController = CoreDataController()
    coreDataController.clearData(for: ["CachedUser", "CachedFriend"])

    return UserListView()
        .environment(
            \.managedObjectContext,
             coreDataController.container.viewContext
        )
}
