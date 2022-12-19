//
//  Roll.swift
//  RollDice
//
//  Created by roberts.kursitis on 19/12/2022.
//

import Foundation

struct Roll: Codable, Hashable {
    var die: String
    var value: Int
    
    static let example = Roll(die: "4", value: 9)
    static let example2 = Roll(die: "4", value: 21)
}
