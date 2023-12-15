//
//  UserDefaultsStore.swift
//  HotProspects
//
//  Created by Eray Diler on 12.12.2023.
//

import Foundation

protocol UserDefaultsStore {
    var key: String { get }

    func fetcth<T: Codable>() -> T?
    func set<T: Codable>(value: T)
}

extension UserDefaultsStore {
    func fetcth<T: Codable>() -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
        }

        return nil
    }

    func set<T: Codable>(value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
