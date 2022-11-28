//
//  Order.swift
//  Project10-CupcakeCorner
//
//  Created by roberts.kursitis on 28/11/2022.
//

import Foundation

class OrderWrapper: ObservableObject {
    struct Order: Codable {
//        enum CodingKeys: CodingKey {
//            case type, quantity, extraFrosting, addSprinkles, name, streetName, city, zip
//        }
        
        static let types = ["vanilla", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetName = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespaces).isEmpty || streetName.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
            
            return true
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2
            cost += (Double(type) / 2)
            
            if extraFrosting {
                cost += Double(quantity)
            }
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
//        init() { }
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//
//            try container.encode(type, forKey: .type)
//            try container.encode(quantity, forKey: .quantity)
//
//            try container.encode(extraFrosting, forKey: .extraFrosting)
//            try container.encode(addSprinkles, forKey: .addSprinkles)
//
//            try container.encode(name, forKey: .name)
//            try container.encode(streetName, forKey: .streetName)
//            try container.encode(city, forKey: .city)
//            try container.encode(zip, forKey: .zip)
//        }
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            type = try container.decode(Int.self, forKey: .type)
//            quantity = try container.decode(Int.self, forKey: .quantity)
//
//            extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//            addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//            name = try container.decode(String.self, forKey: .name)
//            streetName = try container.decode(String.self, forKey: .streetName)
//            city = try container.decode(String.self, forKey: .city)
//            zip = try container.decode(String.self, forKey: .zip)
//
//        }
    }
    @Published var orderStruct = Order()
}
