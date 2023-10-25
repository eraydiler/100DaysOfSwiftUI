//
//  FilteringWithNSPredicate.swift
//  CoreDataProject
//
//  Created by Eray Diler on 23.10.2023.
//

import CoreData
import SwiftUI

///
/// Notes:
/// Because fetch requests are created as properties, and it's not possible to reference properties with each other,
/// we've moved filtering functionality into a dedicated view so that we can update fetchRequest property dynamically.
///
struct DynamicFiltering: View {
    @Environment(\.managedObjectContext) var moc
    @State private var filter = Filter.examples[0]

    var body: some View {
        NavigationStack {
            VStack {
                FilteredListView(filter: filter) { (ship: Ship) in
                    Text(ship.name ?? "Unknown name")
                }
                Picker("Filters", selection: $filter) {
                    ForEach(Filter.examples, id: \.self) {
                        Text($0.title)
                    }
                }
                Button("Add Examples") {
                    let ship1 = Ship(context: moc)
                    ship1.name = "Enterprise"
                    ship1.universe = "Star Trek"

                    let ship2 = Ship(context: moc)
                    ship2.name = "Defiant"
                    ship2.universe = "Star Trek"

                    let ship3 = Ship(context: moc)
                    ship3.name = "Millennium Falcon"
                    ship3.universe = "Star Wars"

                    let ship4 = Ship(context: moc)
                    ship4.name = "Executor"
                    ship4.universe = "Star Wars"

                    try? moc.save()
                }
                .toolbar {
                    Button("Clear") {
                        clearData()
                    }
                }
            }
            .navigationTitle("Filter example")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension DynamicFiltering {
    private func clearData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Ship")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try moc.persistentStoreCoordinator?.execute(deleteRequest, with: moc)
        } catch {
            print(error)
        }
    }
}

#Preview {
    @StateObject var coreDataController = CoreDataController()
    return DynamicFiltering()
        .environment(\.managedObjectContext, coreDataController.container.viewContext)
}
