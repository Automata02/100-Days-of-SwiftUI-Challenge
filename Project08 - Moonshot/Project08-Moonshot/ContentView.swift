//
//  ContentView.swift
//  Project08-Moonshot
//
//  Created by roberts.kursitis on 22/11/2022.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isShowingGrid = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if isShowingGrid {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        VStack {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.75))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                    )
                                    .accessibilityElement(children: .ignore)
                                    .accessibilityLabel(mission.displayName)
                                    .accessibilityHint(mission.formattedLaunchDate)
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    List {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                HStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50)
                                        .padding(.trailing)
                                    HStack {
                                        Text(mission.displayName)
                                            .font(.title3)
                                        Spacer()
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.75))
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.darkBackground)
                    }
                    .listStyle(.plain)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button() {
                    isShowingGrid.toggle()
                } label: {
                    isShowingGrid ? Image(systemName: "square.grid.2x2") : Image(systemName: "rectangle.grid.1x2")
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
