//
//  NewFacesApp.swift
//  NewFaces
//
//  Created by roberts.kursitis on 08/12/2022.
//

import SwiftUI

@main
struct NewFacesApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
