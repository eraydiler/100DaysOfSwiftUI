//
//  Store.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

protocol Store {
    associatedtype T

    var items: [T] { get set }

    func fetch()
    func save()
    func clear()

    func add(item: T)
    func remove(atOffsets: IndexSet)
}
