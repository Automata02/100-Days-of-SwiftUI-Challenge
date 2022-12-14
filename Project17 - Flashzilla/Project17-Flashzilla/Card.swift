//
//  Card.swift
//  Project17-Flashzilla
//
//  Created by roberts.kursitis on 13/12/2022.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let promt: String
    let answer: String
    
    static let example = Card(promt: "Who played The Witcher?", answer: "Henry Cavill(?)")
}
