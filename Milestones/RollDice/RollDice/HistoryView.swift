//
//  HistoryView.swift
//  RollDice
//
//  Created by roberts.kursitis on 19/12/2022.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss.self) var dismiss
    @State var rolls: [Roll]
    @State private var showingDelete = false
    
    var savedDice: [String] {
        var arr = [String]()
        for roll in rolls {
            if !arr.contains(roll.die) {
                arr.append(roll.die)
            }
        }
        return arr
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(rolls.isEmpty ? "No saved rolls!" : "")
                List {
                    ForEach(savedDice.indices, id: \.self) { die in
                            Section("\(savedDice[die])-Sided Die Rolls") {
                                Text(getString(rolls, key: savedDice[die], count: true))
                                Text(getString(rolls, key: savedDice[die], count: false))
                            }
                    }
                }
            }
            .navigationTitle("Roll History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("OK", action: ok)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingDelete = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onAppear {
                if rolls.isEmpty {
                    rolls = loadRolls()
                }
            }
            .actionSheet(isPresented: $showingDelete) {
                ActionSheet(title: Text("Change background"),
                            message: Text("Select a new color"),
                            buttons: [
                                    .destructive(Text("Delete")) {
                                        deleteRolls()
                                        rolls = loadRolls()
                                    },
                                    .cancel()
                                ])
            }
        }
    }
    
    func ok() {
        print(rolls.count)
        dismiss()
    }
    
    func getString(_ rolls: [Roll], key: String, count: Bool) -> String {
        var array = [Int]()
        for roll in rolls {
            if roll.die == key {
                array.append(roll.value)
            }
        }
        if count {
            return "Total number of rolls: \(array.count)"
        } else {
            let stringArray = array.map { String($0) }
            return stringArray.joined(separator: ", ")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(rolls: [Roll.example, Roll.example2])
    }
}
