//
//  Prospect.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import Foundation

class Prospect: Identifiable, Codable {
    private(set) var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    private(set) var creationDate = Date()
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private let store = FileStore(key: "Prospects")

    enum SortType {
        case name, recent
    }

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

    func sortBy(_ type: SortType) {
        objectWillChange.send()

        switch type {
        case .name:
            people.sort { $0.name < $1.name }
        case .recent:
            people.sort { $0.creationDate < $1.creationDate }
        }
    }

    private func save() {
        store.set(value: people)
    }
}
