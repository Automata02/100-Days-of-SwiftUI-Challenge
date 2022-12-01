//
//  NetworkManager.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//

import Foundation

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
}
