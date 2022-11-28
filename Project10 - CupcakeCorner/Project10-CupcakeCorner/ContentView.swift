//
//  ContentView.swift
//  Project10-CupcakeCorner
//
//  Created by roberts.kursitis on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var observed = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $observed.orderStruct.type) {
                        ForEach(OrderWrapper.Order.types.indices, id: \.self) {
                            Text(OrderWrapper.Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(observed.orderStruct.quantity)", value: $observed.orderStruct.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $observed.orderStruct.specialRequestEnabled.animation())
                    if observed.orderStruct.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $observed.orderStruct.extraFrosting)
                        Toggle("Add extra sprinkes", isOn: $observed.orderStruct.addSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: observed)
                    } label: {
                        Text("Delivery detail")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
