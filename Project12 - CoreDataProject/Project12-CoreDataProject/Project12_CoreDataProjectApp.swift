//
//  Project12_CoreDataProjectApp.swift
//  Project12-CoreDataProject
//
//  Created by roberts.kursitis on 30/11/2022.
//

import SwiftUI

@main
struct Project12_CoreDataProjectApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
