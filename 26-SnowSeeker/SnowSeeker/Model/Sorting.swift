//
//  Sorting.swift
//  SnowSeeker
//
//  Created by Eray Diler on 23.01.2024.
//

import Foundation

enum SortType {
    case alphabetical, countryName, size, price
}

struct Sorting {
    var type: SortType

    func buttonColorFor(_ type: SortType) -> Color {
        if self.type == type {
            return .blue
        } else {
            return .secondary
        }
    }
}
