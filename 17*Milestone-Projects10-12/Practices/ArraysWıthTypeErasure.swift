//
//  ArraysWıthTypeErasure.swift
//  Milestone-Projects10-12
//
//  Created by Eray Diler on 26.10.2023.
//

import SwiftUI

struct ArraysWithTypeErasure: View {
    @State private var views = [AnyView]()

    var body: some View {
        VStack {
            Button("Add Shape") {
                if Bool.random() {
                    views.append(AnyView(Circle().frame(height: 50)))
                } else {
                    views.append(AnyView(Rectangle().frame(width: 50)))
                }
            }

            ForEach(0..<views.count, id: \.self) {
                views[$0]
            }

            Spacer()
        }
    }
}

#Preview {
    ArraysWithTypeErasure()
}
