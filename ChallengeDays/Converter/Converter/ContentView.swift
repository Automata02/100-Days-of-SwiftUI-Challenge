//
//  ContentView.swift
//  Converter
//
//  Created by roberts.kursitis on 10/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var myInput: Double = 0
    @State private var selectedUnit: String = "Fahrenheit"
    @FocusState private var inputIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func calculatedValue() -> (fahrenheit: Double, celsius: Double, kelvin: Double) {
        var fahrenheit: Double = 0
        var celsius: Double = 0
        var kelvin: Double = 0
        
        switch selectedUnit {
        case "Celsius":
            fahrenheit = myInput * 1.8 + 32
            kelvin = myInput + 273.15
            celsius = myInput
        case "Fahrenheit":
            fahrenheit = myInput
            kelvin = (myInput - 32) * 5 / 9 + 273.15
            celsius = (fahrenheit - 32) / 1.8
        case "Kelvin":
            fahrenheit = (myInput - 273.15) * 9 / 5
            kelvin = myInput
            celsius = myInput - 273.15
        default:
            print("Oops")
        }
        return (fahrenheit, celsius, kelvin)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $myInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    Picker("Units", selection: $selectedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(5)
                } header: {
                    Text("Now converting \(selectedUnit)")
                }
                Section {
                    HStack {
                        Text("\(calculatedValue().celsius, specifier: "%.2f")ºC")
                        Spacer()
                        Text("\(calculatedValue().fahrenheit, specifier: "%.2f")ºF")
                        Spacer()
                        Text("\(calculatedValue().kelvin, specifier: "%.2f")ºK")
                    }
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Converter💯")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
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
