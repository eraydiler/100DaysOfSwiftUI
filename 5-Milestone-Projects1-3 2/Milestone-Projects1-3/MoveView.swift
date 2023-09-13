//
//  Move.swift
//  Milestone-Projects1-3
//
//  Created by Eray Diler on 13.09.2023.
//

import SwiftUI

struct MoveView: View {
    var move: Move

    var body: some View {
        Text(move.emoji)
            .foregroundColor(move.color)
            .font(.system(size: 100))
    }
}
