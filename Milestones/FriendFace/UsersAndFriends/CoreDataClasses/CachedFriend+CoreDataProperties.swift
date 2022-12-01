//
//  CachedFriend+CoreDataProperties.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: CachedUser?

}

extension CachedFriend : Identifiable {

}
