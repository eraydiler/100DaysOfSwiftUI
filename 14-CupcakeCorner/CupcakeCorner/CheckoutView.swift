//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var order: Order
    @State private var confirmationAlert = Alert(title: "Thank you!")
    @State private var errorAlert = Alert(title: "Oops!")

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()                            .accessibilityHidden(true)
                    case .failure:
                        Text("Image couldn't loaded")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        fatalError("Unknown state")
                    }
                }
                .frame(height: 200)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task { await placeOrder() }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert($confirmationAlert)
        .alert($errorAlert)
    }
}

extension CheckoutView {
    private func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            let confirmedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationAlert.message = "Your order for \(confirmedOrder.quantity)x \(confirmedOrder.type.name.lowercased()) cupcakes is on its way!"
            confirmationAlert.isPresented = true
        } catch  {
            errorAlert.message = "Checkout failed with \(error)"
            errorAlert.isPresented = true
        }
    }
}

#Preview {
    @State var order = Order()
    return CheckoutView(order: $order)
}
