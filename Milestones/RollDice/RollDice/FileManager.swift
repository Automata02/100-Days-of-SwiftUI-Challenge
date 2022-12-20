//
//  FileManager.swift
//  RollDice
//
//  Created by roberts.kursitis on 19/12/2022.
//

import Foundation
import SwiftUI

class Constants {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    enum AllDice: String, CaseIterable {
        case four = "4", six = "6", eight = "8", twelve = "12", twenty = "20", hundred = "100"
        
        func rollDice () -> Int {
            switch(self) {
            case .four:
                return Int.random(in: 1...4)
            case .six:
                return Int.random(in: 1...6)
            case .eight:
                return Int.random(in: 1...8)
            case .twelve:
                return Int.random(in: 1...12)
            case .twenty:
                return Int.random(in: 1...20)
            case .hundred:
                return Int.random(in: 1...100)
            }
        }
    }
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension View {
    
    
    func loadRolls() -> [Roll] {
            if let data = try? Data(contentsOf: Constants.savePath) {
                if let decoded = try? JSONDecoder().decode([Roll].self, from: data) {
                    print("Loaded Data")
                    return decoded
                }
            }
            print("Failed to load, perhaps no saved rolls?")
            return []
        }
        
    func saveRolls(_ rolls: [Roll]) {
        if let encoded = try? JSONEncoder().encode(rolls) {
            try? encoded.write(to: Constants.savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func deleteRolls() {
        let fileManager = FileManager.default
        
        do {
            try fileManager.removeItem(at: Constants.savePath)
        } catch {
            print(error)
        }
        //        if fileManager.fileExists(atPath: Constants.savePath) {
        //            try fileManager.removeItem(atPath: Constants.savePath)
        //        }
        //        if let data = try? Data(contentsOf: Constants.savePath) {
        //
        //        }
    }
}
