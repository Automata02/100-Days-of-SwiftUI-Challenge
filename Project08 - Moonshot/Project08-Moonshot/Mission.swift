//
//  Mission.swift
//  Project08-Moonshot
//
//  Created by roberts.kursitis on 22/11/2022.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    var longFormattedLaunchDate: String {
        launchDate?.formatted(date: .complete, time: .shortened) ?? "N/A"
    }
}
