//
//  Order.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import Foundation

class Order: ObservableObject {
    @Published var type: OrderType = .vanilla
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    @Published var delivery = Delivery()
}

enum OrderType: String, CaseIterable {
    case vanilla, strawberry, chocolate, rainbow

    var name: String {
        rawValue.capitalized
    }

    var indice: Int {
        switch self {
        case .vanilla: 0
        case .strawberry: 1
        case .chocolate: 2
        case .rainbow: 3
        }
    }
}

extension Order {
    struct Delivery {
        var name: String = ""
        var street: String = ""
        var city: String = ""
        var zip: String = ""

        var isValid: Bool {
            !name.isEmpty
            && !street.isEmpty
            && !city.isEmpty
            && !zip.isEmpty
        }
    }
}

extension Order {
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type.indice) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
