//
//  ContentView.swift
//  Project12-CoreDataProject
//
//  Created by roberts.kursitis on 30/11/2022.
//
import CoreData
import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    ShipsView()
                } label: {
                    HStack {
                        Label("Ships",  systemImage: "sailboat.fill")
                            .foregroundColor(.primary)
                            .padding(.trailing, 23)
                        Text("Filtering @FetchRequest using NSPredicate")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                
                NavigationLink {
                    SingerView()
                } label: {
                    HStack {
                        Label("Singer",  systemImage: "music.mic")
                            .foregroundColor(.primary)
                            .padding(.trailing)
                        Text("Dynamically filtering @FetchRequest with SwiftUI")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                
                NavigationLink {
                    CandyView()
                } label: {
                    HStack {
                        Label("Candy", systemImage: "birthday.cake.fill")
                            .foregroundColor(.primary)
                            .padding(.trailing)
                        Text("One-to-many relationships with Core Data, SwiftUI, and @FetchRequest")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("CoreData")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
