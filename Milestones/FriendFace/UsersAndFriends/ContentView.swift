//
//  ContentView.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(networkManager.users) { user in
                        NavigationLink {
                            UserDetailView(user: user)
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
