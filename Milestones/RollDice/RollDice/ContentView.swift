//
//  ContentView.swift
//  RollDice
//
//  Created by roberts.kursitis on 19/12/2022.
//

import SwiftUI

//MARK: Extension to make system fonts larger
public extension UIFont {
    static func textSize(_ style: UIFont.TextStyle) -> CGFloat {
        UIFont.preferredFont(forTextStyle: style).pointSize
    }
}

struct ContentView: View {
    
    @State private var rolls = [Roll]()
    
    @State private var currentDie = Constants.AllDice.four
    @State private var result: Int = 0
    
    @State private var display: String = "1️⃣"
    var randomCharacters = ["???", "🤷", "✨", "💯", "1", "2", "3", "42", "💀", "❤️"]
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var isActive: Bool = false
    @State private var time: Int = 0
    
    @State private var isShowingHistory = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                //MARK: Adding timer logic to the text view itself
                Text(display).onReceive(timer) { _ in
                    if time > 0 && isActive{
                        display = randomCharacters.randomElement() ?? ""
                        time -= 1
                    }else{
                        isActive = false
                        display = String(result)
                    }
                }
                .font(.system(size: UIFont.textSize(.largeTitle) * 2, weight: .semibold))
                .frame(width: 300, height: 300)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(25)
                
                Picker("Select your die", selection: $currentDie) {
                    ForEach(Constants.AllDice.allCases, id: \.self) { die in
                        Text("\(die.rawValue)-sided die")
                    }
                }
                .pickerStyle(.menu)
                .padding(.vertical, 25)
                
                Button("Roll!") {
                    //MARK: Haptics
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    
                    //MARK: Saving roll
                    result = Constants.AllDice.rollDice(currentDie)()
                    let roll = Roll(die: currentDie.rawValue, value: result)
                    rolls.append(roll)
                    saveRolls(rolls)
                    
                    //MARK: Triggering timer
                    time += 15
                    isActive = true
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
