//
//  Move.swift
//  Milestone-Projects1-3
//
//  Created by Eray Diler on 13.09.2023.
//

import SwiftUI

enum MoveType: String {
    case rock, paper, scissors
}

struct Move {
    let type: MoveType
    let color: Color

    var title: String {
        return type.rawValue.capitalized
    }

    var emoji: String {
        switch type {
        case .rock:
            "🪨"
        case .paper:
            "📜"
        case .scissors:
            "✂️"
        }
    }

    func beats(_ move: Move) -> Bool {
        if self == move { return false }

        switch type {
        case .rock:
            return move.type == .scissors
        case .paper:
            return move.type == .rock
        case .scissors:
            return move.type == .paper
        }
    }
}

extension Move: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.type == rhs.type
    }
}
