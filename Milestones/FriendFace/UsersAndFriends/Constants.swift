//
//  Constants.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//

import Foundation

class Constants {
    static let apiUrl = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
    
    //MARK: Sample user
    static let aboutText = "Aliquip incididunt dolor anim ullamco dolor ullamco qui amet sit non et eiusmod. Dolore aliqua cillum amet eu ex culpa deserunt adipisicing tempor aute nisi. Laborum tempor eiusmod dolore voluptate ex est exercitation occaecat ullamco. Sunt aliquip culpa sunt consequat sunt nisi ipsum nisi fugiat."
    static var bob = User(id: UUID(), isActive: true, name: "Bob Bobertson", age: 21, email: "bob@bob.com", address: "Moondrive avenue 20", company: "Twinkie Factory", registered: Date.now, about: aboutText, friends: [])
    
    static var bobbert = CachedUser.self
}
