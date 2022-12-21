//
//  ContentView.swift
//  Project19-SnowSeeker
//
//  Created by roberts.kursitis on 20/12/2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    enum sortingStyles {
        case alphabetical, country, none
    }
    @State private var sortingOrder = sortingStyles.none
    @State private var isSortPrompShown = false
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isSortPrompShown = true
                    } label: {
                        //MARK: arrow.up.arrow.down seems to be the correct image to use for sorting(?)
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            //MARK: ActionSheet is depracated, using confirmationDialog
            .confirmationDialog("Select sorting style", isPresented: $isSortPrompShown, titleVisibility: .visible) {
                Button("Sort by Name") {
                    sortingOrder = .alphabetical
                }
                Button("Sort by Country") {
                    sortingOrder = .country
                }
                Button("Default") {
                    sortingOrder = .none
                }
            }
            
            WelcomeView()
        }
        .phoneOnlyNavigationView()
        //MARK: Gives access to it in all the views as it gets passed as an enviromentObject
        .environmentObject(favorites)
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortingOrder {
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        case .none:
            return filteredResorts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
