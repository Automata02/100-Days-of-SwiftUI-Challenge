//
//  User.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 30/11/2022.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var email: String
    var address: String
    var company: String
    var registered: Date
    var about: String
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
