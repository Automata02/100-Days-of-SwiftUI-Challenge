//
//  Favorites.swift
//  Project19-SnowSeeker
//
//  Created by roberts.kursitis on 21/12/2022.
//

import Foundation

//MARK: Saving done in documents with a JSON file.

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
