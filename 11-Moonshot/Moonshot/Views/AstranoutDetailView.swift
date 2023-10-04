//
//  AstranoutDetailView.swift
//  Moonshot
//
//  Created by Eray Diler on 4.10.2023.
//

import SwiftUI

struct AstranoutDetailView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstranoutDetailView(astronaut: astronauts["armstrong"]!)
}
