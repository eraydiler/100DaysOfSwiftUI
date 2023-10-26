//
//  FriendDetailView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

struct FriendDetailView: View {
    let friend: User.Friend

    var body: some View {
        VStack {
            Text(friend.name)
                .font(.largeTitle)
        }
    }
}

#Preview {
    FriendDetailView(friend: User.testUser.friends[0])
}
