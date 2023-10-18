//
//  Order.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import Foundation

class OrderDraft: ObservableObject {
    @Published var order = Order()
}

struct Order: Codable {
    var type: OrderType = .vanilla
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var delivery = Delivery()

    init() { }

    enum CodingKeys: CodingKey {
        case type
        case quantity
        case extraFrosting
        case addSprinkles
        case delivery
    }
}

enum OrderType: String, CaseIterable, Codable {
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
    struct Delivery: Codable {
        var name: String = ""
        var street: String = ""
        var city: String = ""
        var zip: String = ""

        var isValid: Bool {
            !name.trimmingCharacters(in: .whitespaces).isEmpty
            && !street.trimmingCharacters(in: .whitespaces).isEmpty
            && !city.trimmingCharacters(in: .whitespaces).isEmpty
            && !zip.trimmingCharacters(in: .whitespaces).isEmpty
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
