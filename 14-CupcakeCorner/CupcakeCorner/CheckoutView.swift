//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
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
                
                Button("Place Order", action: { })
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let order = Order()
    return CheckoutView(order: order)
}
