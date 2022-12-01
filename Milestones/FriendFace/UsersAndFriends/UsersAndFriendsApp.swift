//
//  UsersAndFriendsApp.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 30/11/2022.
//

import SwiftUI

@main
struct UsersAndFriendsApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
