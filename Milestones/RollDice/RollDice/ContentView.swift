//
//  ContentView.swift
//  RollDice
//
//  Created by roberts.kursitis on 19/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rolls = [Roll]()
    
    @State private var currentDie = Constants.AllDice.four
    @State private var result: Int = 0
    
    @State private var display: String = "1️⃣"
    var randomCharacters = ["???", "🤷", "✨", "💯", "1", "2", "3", "42", "💀", "❤️"]
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var isShowingHistory = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text(display)
                    .font(.largeTitle)
                    .frame(width: 300, height: 300)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(25)
                
                Text(String(result))
                    .font(.largeTitle)
                
                Picker("Select your die", selection: $currentDie) {
                    ForEach(Constants.AllDice.allCases, id: \.self) { die in
                        Text("\(die.rawValue)-sided die")
                    }
                }
                .pickerStyle(.menu)
                
                Button("Roll!") {
                    //MARK: Haptics
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    
                    //MARK: Saving roll
                    result = Constants.AllDice.rollDice(currentDie)()
                    let roll = Roll(die: currentDie.rawValue, value: result)
                    rolls.append(roll)
                    saveRolls(rolls)
                }
                .frame(width: 150, height: 100)
                .background(.green)
                .foregroundColor(.white)
                .font(.largeTitle)
                .cornerRadius(25)
                
            }
            .padding(.vertical, 45)
            .navigationTitle("Dice Roll")
            .sheet(isPresented: $isShowingHistory) {
                HistoryView(rolls: loadRolls())
            }
            .onAppear {
                rolls = loadRolls()
            }
            .toolbar {
                Button {
                    isShowingHistory = true
                } label: {
                    Label("history", systemImage: "clock.fill")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
