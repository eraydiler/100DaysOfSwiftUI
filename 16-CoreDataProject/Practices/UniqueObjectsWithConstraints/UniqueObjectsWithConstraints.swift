//
//  UniqueObjectsWithConstraints.swift
//  CoreDataProject
//
//  Created by Eray Diler on 23.10.2023.
//

import SwiftUI

///
/// .xcdataModel -> Select Wizard -> Menu -> View -> Inspectors -> Data Model -> add relevant fields into Constraints
///

struct UniqueObjectsWithConstraints: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    @StateObject var coreDataController = CoreDataController()
    return UniqueObjectsWithConstraints()
        .environment(\.managedObjectContext, coreDataController.container.viewContext)

}
