//
//  Order.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 17.10.2023.
//

import Foundation

class Order: ObservableObject, Codable {
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

    init() { }

    enum CodingKeys: CodingKey {
        case type
        case quantity
        case extraFrosting
        case addSprinkles
        case delivery
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(OrderType.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        delivery = try container.decode(Delivery.self, forKey: .delivery)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(delivery, forKey: .delivery)
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
