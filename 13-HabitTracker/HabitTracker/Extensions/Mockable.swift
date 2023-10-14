//
//  Mocker.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

protocol Mockable {
    associatedtype T
    static func generateMockedItems(_ numberOfActivities: Int) -> [T]
}
