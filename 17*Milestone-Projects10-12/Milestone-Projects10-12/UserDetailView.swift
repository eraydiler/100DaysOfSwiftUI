//
//  UserDetailView.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack {
                Text(user.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top)
                
                Text("( " + user.age.formatted() + " )")
                    .fontWeight(.bold)
                    .font(.title2)

                Text(user.company)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.top, 1)

                Text(user.about)
                    .font(.body)
                    .padding()

                Text("Registered: " + user.registered.formatted())
                    .font(.footnote)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(user.friends) { friend in
                            NavigationLink {
                                FriendDetailView(friend: friend)
                            } label: {
                                Text(friend.name)
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
    }
}

#Preview {
    UserDetailView(user: User.testUser)
}
