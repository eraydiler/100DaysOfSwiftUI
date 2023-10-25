//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Eray Diler on 23.10.2023.
//

import CoreData
import SwiftUI

fileprivate struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(
        sortDescriptors: [SortDescriptor<T>] = [],
        predicate: Predicate,
        filterKey: String,
        filterValue: String,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: [],
            predicate: NSPredicate(
                format: "%K \(predicate.rawValue) %@",
                filterKey,
                filterValue
            )
        )
        self.content = content
    }
}

fileprivate enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
}

struct Challenges: View {
    @Environment(\.managedObjectContext) private var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(
                sortDescriptors: [
                    SortDescriptor(\.firstName),
                    SortDescriptor(\.lastName)
                ],
                predicate: .beginsWith,
                filterKey: "lastName",
                filterValue: lastNameFilter) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

#Preview {
    Challenges()
}
