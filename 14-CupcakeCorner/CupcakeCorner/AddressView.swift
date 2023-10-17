//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.delivery.name)
                TextField("Street address", text: $order.delivery.street)
                TextField("City", text: $order.delivery.city)
                TextField("Zip", text: $order.delivery.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.delivery.isValid)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let order = Order()
    return AddressView(order: order)
}
