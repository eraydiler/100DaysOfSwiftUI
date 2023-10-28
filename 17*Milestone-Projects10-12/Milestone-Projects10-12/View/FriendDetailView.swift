//
//  FriendDetailView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: CachedFriend

    var body: some View {
        VStack {
            Text(friend.wrappedName)
                .font(.largeTitle)
        }
        .navigationTitle(friend.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let context = CoreDataController().container.viewContext
    let cachedUser = try? CachedUser(user: User.testUser, insertInto: context)
    return FriendDetailView(friend: cachedUser!.wrappedFriends[0])
}
