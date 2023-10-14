//
//  MutableCollection+Additions.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

public extension MutableCollection where Self: RandomAccessCollection {
    mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
