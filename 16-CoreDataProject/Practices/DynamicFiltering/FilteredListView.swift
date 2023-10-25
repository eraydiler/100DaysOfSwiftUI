//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Eray Diler on 25.10.2023.
//

import CoreData
import Foundation
import SwiftUI

struct FilteredListView<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content

    init(filter: Filter, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest(sortDescriptors: [], predicate: filter.predicate)
        self.content = content
    }

    var body: some View {
        VStack {
            List(fetchRequest, id: \.self) { item in
                self.content(item)
            }
        }
    }
}

