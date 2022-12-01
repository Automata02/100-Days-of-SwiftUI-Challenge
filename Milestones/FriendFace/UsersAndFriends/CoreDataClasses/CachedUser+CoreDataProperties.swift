//
//  CachedUser+CoreDataProperties.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var company: String?
    @NSManaged public var registered: Date?
    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var address: String?
    @NSManaged public var friends: CachedFriend?

}

extension CachedUser : Identifiable {

}
