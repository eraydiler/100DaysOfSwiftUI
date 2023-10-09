//
//  HierarchicalCodable .swift
//  Moonshot
//
//  Created by Eray Diler on 2.10.2023.
//

import SwiftUI

fileprivate struct User: Codable {
    let name: String
    let address: Address
}

fileprivate struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodable: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

#Preview {
    HierarchicalCodable()
}
