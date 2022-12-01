//
//  ContentView.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink {
                        TestView()
                    } label: {
                        VStack(alignment: .leading) {
                            Text("TestView")
                            Text("Main view with CoreData")
                                .font(.caption2)
                        }
                    }
                    ForEach(networkManager.users) { user in
                        NavigationLink {
                            UserDetailView(user: user, cachedUser: nil)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                Text(user.isActive ? "Currently is active!" : "User isn't active.")
                                    .foregroundColor(user.isActive ? .green : .pink)
                                    .font(.caption2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
