//
//  TestView.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//

import SwiftUI

struct TestView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users, id: \.self) { user in
                        NavigationLink {
//                            UserDetailView(user: user)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.name ?? "")
                                Text(user.isActive ? "Currently is active!" : "User isn't active.")
                                    .foregroundColor(user.isActive ? .green : .pink)
                                    .font(.caption2)
                            }
                        }
                    }
                }
                .task {
                    await loadUsers()
                }
            }
            .navigationTitle("FriendFaceTest")
        }
    }
    
    func loadUsers() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: Constants.apiUrl)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                setupCoreData(decodedUsers)
            }
        } catch {
            print("something went horribly wrong!")
        }
    }
    
    func setupCoreData(_ newUsers: [User]) {
        for user in newUsers {
            let cachedUser = CachedUser(context: moc)
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.company = user.company
            cachedUser.registered = user.registered
            cachedUser.about = user.about
        }
        
        try? moc.save()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
