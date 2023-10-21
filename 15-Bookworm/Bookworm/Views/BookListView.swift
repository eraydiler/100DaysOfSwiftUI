//
//  ContentView.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import CoreData
import SwiftUI

/**
    Challenges
    1. Right now it’s possible to select no title, author, or genre for books, which causes a problem for the detail view.
       Please fix this, either by forcing defaults, validating the form, or showing a default picture for unknown genres – you can choose.
    2. Modify ContentView so that books rated as 1 star are highlighted somehow, such as having their name shown in red.
    3. Add a new “date” attribute to the Book entity, assigning Date.now to it so it gets the current date and time, then format that nicely somewhere in DetailView.
 */

struct BookListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    @State private var showAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 2 ? .red : .primary)
                                Text(book.author ?? "Unknown author")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                BookAdditionView()
            }
        }
    }
}

extension BookListView {
    private func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            context.delete(book)
        }

        try? context.save()
    }
}

#Preview {
    @StateObject var coreDataController = CoreDataController()

    return BookListView()
        .environment(\.managedObjectContext, coreDataController.container.viewContext)
}
