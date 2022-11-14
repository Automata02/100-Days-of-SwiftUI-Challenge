//
//  ContentView.swift
//  WeSplit
//
//  Created by roberts.kursitis on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var ammountIsFocused: Bool
    @FocusState private var percentIsFocused: Bool
    
//    let tipPercentages = [0, 10, 15, 20, 25]
    let bigBucks = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "EUR")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercent)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amanoutPerPerson = grandTotal / peopleCount
        
        return amanoutPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: bigBucks)
                        .keyboardType(.decimalPad)
                        .focused($ammountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<26) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .foregroundColor(tipPercent == 0 ? .red : .green)
                    .pickerStyle(.navigationLink)
                    .focused($percentIsFocused)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: bigBucks)
                } header: {
                    Text("Amount per person:")
                }
                Section {
                    Text(totalPerPerson * Double(numberOfPeople + 2), format: bigBucks)
                } header: {
                    Text("Order total with tip:")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        ammountIsFocused = false
                    }
                }
            }
        }
    }
    func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
