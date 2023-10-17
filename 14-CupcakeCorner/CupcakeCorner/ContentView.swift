//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 16.10.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(OrderType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.navigationLink)

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...10)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles?", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(order: order)
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
