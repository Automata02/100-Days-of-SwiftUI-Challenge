//
//  Project11_BookwormApp.swift
//  Project11-Bookworm
//
//  Created by roberts.kursitis on 29/11/2022.
//

import SwiftUI

@main
struct Project11_BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //MARK: injects context for CoreData(?)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
