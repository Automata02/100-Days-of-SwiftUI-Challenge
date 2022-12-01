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
    
    
    //MARK: Dummy person
    static let aboutText = "Aliquip incididunt dolor anim ullamco dolor ullamco qui amet sit non et eiusmod. Dolore aliqua cillum amet eu ex culpa deserunt adipisicing tempor aute nisi. Laborum tempor eiusmod dolore voluptate ex est exercitation occaecat ullamco. Sunt aliquip culpa sunt consequat sunt nisi ipsum nisi fugiat."
    static var bob = User(id: UUID(), isActive: true, name: "Bob Bobertson", age: 21, email: "bob@bob.com", address: "Moondrive avenue 20", company: "Twinkie Factory", registered: Date.now, about: aboutText, friends: [])
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

class NetworkManager: ObservableObject {
    @Published var users = [User]()
    
    init() {
        print("Did call getUsers")
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        URLSession.shared.dataTask(with: url) { [self] (data, _, _) in
            guard let data = data else { return }
            if let decodedData = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async { [self] in
                    users = decodedData.sorted(by: {$0.name < $1.name} )
                    print("Did Fetch Users")
                }
            }
        }.resume()
    }
//    func getUsers() async {
//        print("Did call getUsers")
//
//        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
//
//        do {
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedData = try? decoder.decode([User].self, from: data) {
//                users = decodedData.sorted(by: {$0.name < $1.name} )
//            }
//        } catch {
//            print("something went wrong")
//        }
//    }
}
