//
//  Prospect.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private let store = Store()

    init() {
        people = store.fetcth() ?? []
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        store.set(value: people)
    }
}

extension Prospects {
    fileprivate struct Store: UserDefaultsStore {
        var key: String { "com.hotprospects.prospects" }
    }
}
