//
//  Sequence+Additions.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
