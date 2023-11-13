//
//  Comparable.swift
//  BucketList
//
//  Created by Eray Diler on 6.11.2023.
//

import SwiftUI

fileprivate struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ComparableExample: View {
    // Able to use sorted() method on arrays directly thanks to `Comparable` protocol
    fileprivate let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

#Preview {
    ComparableExample()
}
