//
//  User.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]

    struct Friend: Codable, Identifiable {
        var id: String
        var name: String
    }
    var friends: [Friend]
}

extension User {
    static var testUser: User {
        User(
            id: UUID().uuidString,
            isActive: true,
            name: "Johnny Appleseed",
            age: 32,
            company: "Apple Inc.",
            email: "johnappleseed@apple.com",
            address: "Cupertino CA 95014",
            about: "Johnny Appleseed was an American pioneer nurseryman, who introduced apple trees to large parts of Pennsylvania, Ohio, Indiana, Illinois, and present-day Ontario, as well as the northern counties of present-day West Virginia. He became an American legend while still alive, due to his kind, generous ways, his leadership in conservation, and the symbolic importance he attributed to apples.",
            registered: ISO8601DateFormatter().date(from: "2015-11-10T01:47:18-00:00")!,
            tags: ["apple", "trees", "seed", "nurseryman"],
            friends: [
                Friend(id: UUID().uuidString, name: "Friend1"),
                Friend(id: UUID().uuidString, name: "Friend2"),
                Friend(id: UUID().uuidString, name: "Friend3"),
                Friend(id: UUID().uuidString, name: "Friend4"),
                Friend(id: UUID().uuidString, name: "Friend5"),
            ]
        )
    }
}
