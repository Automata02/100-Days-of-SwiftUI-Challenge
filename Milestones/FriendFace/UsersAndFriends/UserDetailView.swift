//
//  UserDetailView.swift
//  UsersAndFriends
//
//  Created by roberts.kursitis on 01/12/2022.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Text(user.about)
                        Text("Works at \(user.company)")
                            .padding()
                    }
                } header: {
                    Label("about \(user.name)", systemImage: "person.circle.fill")
                }
                
                Section {
                    Link(user.email, destination: URL(string: "mailto:\(user.email)")!)
                } header: {
                    Label("e-mail", systemImage: "envelope.circle.fill")
                }
                
                Section {
                    Text(user.address)
                } header: {
                    Label("Address", systemImage: "mappin.circle.fill")
                }
                
                Section {
                    Text(user.registered.formatted(date: .long, time: .omitted))
                } header: {
                    Label("Registration Date", systemImage: "calendar.circle.fill")
                }
            }
            .navigationTitle(user.name)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {

        UserDetailView(user: User.bob)
    }
}
