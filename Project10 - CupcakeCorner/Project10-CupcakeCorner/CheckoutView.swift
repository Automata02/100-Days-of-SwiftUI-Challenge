//
//  CheckoutView.swift
//  Project10-CupcakeCorner
//
//  Created by roberts.kursitis on 28/11/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderWrapper
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    
    @State private var errorMsg = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 333, height: 233)
                .cornerRadius(10)
                
                
                Text("Your total is \(order.orderStruct.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order Details.", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Problem placing order.", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMsg)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.orderStruct) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            //MARK: Handling data
            let decodedOrder = try JSONDecoder().decode(OrderWrapper.Order.self, from: data)
            confirmationMessage = "\(decodedOrder.name)'s order for \(decodedOrder.quantity)x \(OrderWrapper.Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            errorMsg = "Sorry, failed to place an order! \n Try again later!"
            showingError = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderWrapper())
    }
}
