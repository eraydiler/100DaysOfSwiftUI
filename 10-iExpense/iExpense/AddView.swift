//
//  AddView.swift
//  iExpense
//
//  Created by Eray Diler on 1.10.2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var expenses: Expenses

    @State var name = ""
    @State private var type = "Personal"
    @State var amount = 0.0

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseItem.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    saveExpense()
                    dismiss()
                }
            }
        }
    }

    private func saveExpense() {
        let item = ExpenseItem(name: name, type: type, amount: amount)
        expenses.items.append(item)
    }
}

#Preview {
    AddView(expenses: Expenses())
}
