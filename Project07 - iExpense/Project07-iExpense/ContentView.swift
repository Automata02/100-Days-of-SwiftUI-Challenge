//
//  ContentView.swift
//  Project07-iExpense
//
//  Created by roberts.kursitis on 21/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var allExpenses: [[ExpenseItem]] {
        var business = [Any]()
        var personal = [Any]()
        for item in expenses.items {
            item.type == "Personal" ? personal.append(item) : business.append(item)
        }
        return [personal, business] as? [[ExpenseItem]] ?? [[]]
    }
    
    var myColor: Color {
        return .yellow
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allExpenses.indices, id: \.self) { indice in
                    Section(indice.description.contains("0") ? "Personal expenses" : "Business expenses") {
                        ForEach(allExpenses[indice]) { entry in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.name)
                                        .font(.headline)
                                    Text(entry.type)
                                }
                                Spacer()
                                Text(entry.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(colorPick(entry.amount))
                            }
                        }
                        .onDelete { dinky in
                            guard let firstIndex = dinky.first else { return }
                            expenses.removeItems(for: allExpenses[indice][firstIndex].id)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func colorPick(_ amount: Double) -> Color {
        switch amount {
        case 0...10:
            return .primary
        case 11...100:
            return .green
        case 101...999:
            return .yellow
        default:
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
