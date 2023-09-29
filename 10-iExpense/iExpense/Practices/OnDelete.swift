//
//  State.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

struct OnDeleteView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(_ offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    OnDeleteView()
}
