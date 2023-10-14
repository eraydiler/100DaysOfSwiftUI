//
//  ActivityStore.swift
//  HabitTracker
//
//  Created by Eray Diler on 14.10.2023.
//

import Foundation

class ActivityStore: Store, ObservableObject {
    private let userDefaultKey = Bundle.main.bundleIdentifier! + "." + "activities"

    @Published var items: [Activity] = [] {
        didSet {
            save()
        }
    }

    init() {
        fetch()
    }

    func fetch() {
        self.items = UserDefaults.standard.items(forKey: userDefaultKey)
            .sorted(by: \.creationDate)
    }

    func save() {
        UserDefaults.standard.set(items, forKey: userDefaultKey)
    }

    func clear() {
        items.removeAll()
    }

    func add(item: Activity) {
        items.append(item)
    }

    func remove(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
