//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Eray Diler on 1.10.2023.
//

import Foundation

class Expenses: ObservableObject {
    private let userDefaultKey = "com.Expense.ExpenseItems"

    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: userDefaultKey)
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey),
           let items = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
            self.items = items
        } else {
            self.items = []
        }
    }
}
