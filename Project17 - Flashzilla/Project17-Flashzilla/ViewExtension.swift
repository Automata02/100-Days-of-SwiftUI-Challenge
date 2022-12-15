//
//  ViewExtension.swift
//  Project17-Flashzilla
//
//  Created by roberts.kursitis on 15/12/2022.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
    
    func loadDataFromDocs() -> [Card] {
        if let data = try? Data(contentsOf: Constants.savePath) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    func saveDataInDocs(_ cards: [Card]) {
        if let encoded = try? JSONEncoder().encode(cards) {
            try? encoded.write(to: Constants.savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
