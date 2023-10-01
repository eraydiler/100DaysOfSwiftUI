//
//  ChallengeView.swift
//  iExpense
//
//  Created by Eray Diler on 1.10.2023.
//

import SwiftUI

/// 
/// 1. Use the user’s preferred currency, rather than always using US dollars.
/// 2. Modify the expense amounts in ContentView to contain some styling depending on
///    their value – expenses under $10 should have one style, expenses under $100 another,
///    and expenses over $100 a third style. What those styles are depend on you.
/// 3. For a bigger challenge, try splitting the expenses list into two sections: 
///    one for personal expenses, and one for business expenses. This is tricky for a few 
///    reasons, not least because it means being careful about how items are deleted!

struct ChallengeView: View {
    @StateObject private var expenses = Expenses()
    @State var isSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.groups, id: \.title) { group in
                    Section(group.title) {
                        ForEach(group.items) { item in
                            ExpenseItemRow(item: item)
                                .listRowBackground(color(for: item))
                        }
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

    private func color(for item: ExpenseItem) -> Color {
        let color: Color

        if item.amount < 10 {
            color = Color.green
        } else if item.amount < 100 {
            color = Color.orange
        } else {
            color = Color.red
        }

        return color
    }
}

struct ExpenseItemRow: View {
    let item: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .font(.subheadline)
            }
            Spacer()
            Text(
                item.amount,
                format: .currency(
                    code: Locale.current.currency?.identifier ?? "USD"
                )
            )
        }
    }
}

#Preview {
    ChallengeView()
}
