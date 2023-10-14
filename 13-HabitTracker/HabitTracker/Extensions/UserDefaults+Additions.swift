//
//  UserDefaults+Additions.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

extension UserDefaults {
    func set<T: Codable>(_ items: [T], forKey key: String) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func items<T: Codable>(forKey key: String) -> [T] {
        if let data = UserDefaults.standard.data(forKey: key),
           let items = try? JSONDecoder().decode([T].self, from: data) {
            return items
        }

        return []
    }
}
