//
//  ContentView.swift
//  Project02-GuessTheFlag
//
//  Created by roberts.kursitis on 10/11/2022.
//

import SwiftUI

extension View {
    func styleFlags() -> some View {
        modifier(FlagMod())
    }
    
    func styleSubtitle() -> some View {
        modifier(SubtitleMod())
    }
    
    func styleTitle() -> some View {
        modifier(TitleMod())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var gameCounter = 0
    @State private var gameOver = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(uiColor: .systemGray2), Color(uiColor: .systemGray)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .styleSubtitle()
                        Text(countries[correctAnswer])
                            .styleTitle()
                    }
                    .modifier(TitleMod())
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                        }
                        .styleFlags()
                    }
                }
                .padding(20)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline.bold())
                Spacer()
            }
            .padding(20)
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text(scoreMessage)
            }
            
            .alert("Game finished!", isPresented: $gameOver) {
                Button("New Game") {
                    gameCounter = 0
                    score = 0
                }
            } message: {
                Text("You've answered correctly \(score) out of 10 times.")
            }
        }
    }
    
    //MARK: Flag Button Logic
    func flagTapped(_ number: Int) {
        gameCounter += 1
        if gameCounter == 10 {
            gameOver = true
        }
        
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
            scoreMessage = "Your score is \(score)."
        } else {
            score += 1
            scoreTitle = "Wrong!"
            scoreMessage = "Correct answer was \(correctAnswer)."
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

//MARK: Modifiers for styling
struct SubtitleMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.white)
    }
}

struct TitleMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle.weight(.black))
    }
}

struct FlagMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color(hue: 0, saturation: 0, brightness: 0.8), radius: 6, x: -3, y: -3)
            .shadow(color: Color(hue: 0, saturation: 0, brightness: 0.4), radius: 6, x: 3, y: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
