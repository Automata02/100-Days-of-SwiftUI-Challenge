//
//  ExpenseMode.swift
//  Project07-iExpense
//
//  Created by roberts.kursitis on 21/11/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
