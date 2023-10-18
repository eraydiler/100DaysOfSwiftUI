//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var draft = OrderDraft()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $draft.order.type) {
                        ForEach(OrderType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.navigationLink)

                    Stepper("Number of cakes: \(draft.order.quantity)", value: $draft.order.quantity, in: 1...10)
                }

                Section {
                    Toggle("Any special requests?", isOn: $draft.order.specialRequestEnabled.animation())

                    if draft.order.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $draft.order.extraFrosting)
                        Toggle("Add sprinkles?", isOn: $draft.order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(order: $draft.order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
