//
//  UserDetailView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import CoreData
import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) private var moc
    let user: CachedUser

    var body: some View {
        ScrollView {
            VStack {
                Text(user.wrappedName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top)
                
                Text("( " + user.age.formatted() + " )")
                    .fontWeight(.bold)
                    .font(.title2)

                Text(user.wrappedCompany)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.top, 1)

                Text(user.wrappedAbout)
                    .font(.body)
                    .padding()

                Text("Register  ed: " + user.wrappedRegistered)
                    .font(.footnote)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.wrappedFriends) { friend in
                            NavigationLink {
                                if let user = findUser(for: friend) {
                                    UserDetailView(user: user)
                                } else {
                                    FriendDetailView(friend: friend)
                                }
                            } label: {
                                Text(friend.wrappedName)
                                    .font(.callout)
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .padding()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension UserDetailView {
    func findUser(for friend: CachedFriend) -> CachedUser? {
        let fetchRequest = CachedUser.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "id == %@", friend.id ?? ""
        )

        do {
            return try moc.fetch(fetchRequest).first
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }
}

#Preview {
    let context = CoreDataController().container.viewContext
    let cachedUser = try? CachedUser(user: User.testUser, insertInto: context)
    return UserDetailView(user: cachedUser!)
}
