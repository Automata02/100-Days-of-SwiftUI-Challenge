//
//  ContentView.swift
//  Project02-GuessTheFlag
//
//  Created by roberts.kursitis on 10/11/2022.
//

import SwiftUI

//MARK: View styling extension w/ modifiers
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
    
    @State private var flagRotationDegrees = 0.0
    @State private var selectedFlag: Int = 0
    @State private var isCorrectFlag = false
    @State private var isTranslucent = false
    @State private var isBlended = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                    VStack {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                                selectedFlag = number
                                withAnimation{
                                    flagRotationDegrees = 360
                                    isTranslucent.toggle()
                                    isBlended.toggle()
                                }
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                            }
                            .styleFlags()
                            .opacity(isTranslucent && selectedFlag != number ? 0.25 : 1)
                            .scaleEffect(isTranslucent && selectedFlag != number ? 0.95 : 1)
                            .rotation3DEffect(.degrees(selectedFlag == number && isCorrectFlag ? flagRotationDegrees : 0), axis: (x: 0, y: 1, z: 0))
                            .blendMode(isBlended && !isCorrectFlag ? .luminosity : .normal)
                        }
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
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue") {
                    askQuestion()
                    flagRotationDegrees = 0.0
                    isCorrectFlag = false
                    isTranslucent.toggle()
                    isBlended.toggle()
                }
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
            isCorrectFlag.toggle()
            score += 1
            scoreTitle = "Correct!"
            scoreMessage = " That is the \(countries[correctAnswer]) flag. Your score is \(score)."
        } else {
            score += 1
            scoreTitle = "Wrong!"
            
            switch correctAnswer {
            case 0:
                scoreMessage = "Sorry, it was the \(correctAnswer + 1)st flag."
            case 1:
                scoreMessage = "Sorry, it was the \(correctAnswer + 1)nd flag."
            case 2:
                scoreMessage = "Sorry, it was the \(correctAnswer + 1)rd flag."
            default:
                scoreMessage = "Something went wrong."
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showingScore = true
        }
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
            .padding(15)
            .shadow(color: Color(hue: 0, saturation: 0, brightness: 0.8), radius: 6, x: -3, y: -3)
            .shadow(color: Color(hue: 0, saturation: 0, brightness: 0.4), radius: 6, x: 3, y: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
