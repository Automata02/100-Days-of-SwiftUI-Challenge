//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by roberts.kursitis on 14/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var hands = ["✊", "✋", "✌️"]
    @State private var phoneHand = Int.random(in: 0...2)
    @State private var gameType = Bool.random()
    @State private var showingResult = false
    @State private var score = 0
    
    @State private var alertWatcher = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .systemGray4)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("\(gameType ? "Beat" : "Lose to") \(hands[phoneHand])!")
                        .padding(20)
                        .background(gameType ? .green : .red)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Spacer()
                    HStack {
                        ForEach(0..<3) { hand in
                            Button {
                                choiceTapped(hand)
                            } label: {
                                Text(hands[hand])
                                    .font(.title)
                            }
                            .padding(15)
                            .background(.blue)
                            .cornerRadius(.infinity)
                        }
                        .padding(5)
                    }
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                    Spacer()
                }
            }
            .alert(alertTitle, isPresented: $showingResult) {
                Button("Ok") {}
            } message: {
                Text(alertMsg)
            }
            .navigationTitle("✊✋✌️")
        }
    }
    
    func choiceTapped(_ hand: Int) {
        if phoneHand == hand - 1 || phoneHand - 2 == hand {
            gameType ? print("good job") : print("try again")
            gameType ? alertWatcher.toggle() : print("🤷‍♀️")
        } else if phoneHand == hand {
            print("same hand")
        } else if phoneHand - 1 == hand || phoneHand + 2 == hand {
            !gameType ? print("good job") : print("try again")
            !gameType ? alertWatcher.toggle() : print("🤷‍♀️")
        }
        alertUpdate()
        showingResult = true
        gameType.toggle()
        phoneHand = Int.random(in: 0...2)
    }
    
    func alertUpdate() {
        if alertWatcher {
            alertTitle = "Wow!"
            alertMsg = "Good job!"
            score += 1
        } else {
            alertTitle = "😭"
            alertMsg = "This won't do, try again!"
        }
        alertWatcher = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
