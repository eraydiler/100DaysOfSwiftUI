//
//  ContentView.swift
//  iExpense
//
//  Created by Eray Diler on 28.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var expenses = Expenses()

    @State var isSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)
                            Text(expense.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(expense.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button("", systemImage: "plus") {
                    isSheetPresented = true
                }
            }
            .sheet(isPresented: $isSheetPresented, content: {
                AddView(expenses: expenses)
            })
        }
    }

    private func delete(_ offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
