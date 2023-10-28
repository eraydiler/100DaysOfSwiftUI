//
//  CachedUser+CoreDataProperties.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 27.10.2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {
    var wrappedName: String {
        name ?? "Unknown Name"
    }

    var wrappedCompany: String {
        company ?? "No Company"
    }

    var wrappedAbout: String {
        about ?? "No Details"
    }

    var wrappedRegistered: String {
        registered?.formatted() ?? "No registration date"
    }

    var wrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

    @discardableResult
    convenience init(user: User, insertInto context: NSManagedObjectContext) throws {
        self.init(context: context)
        self.id = user.id
        self.about = user.about
        self.address = user.address
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email

        for friend in user.friends {
            let cachedFriend = CachedFriend(context: context)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            addToFriends(cachedFriend)
        }

        self.isActive = user.isActive
        self.name = user.name
        self.registered = user.registered
        self.tags = user.tags.joined(separator: ",")
    }
}
