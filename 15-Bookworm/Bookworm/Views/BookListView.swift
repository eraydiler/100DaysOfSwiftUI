//
//  ContentView.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import CoreData
import SwiftUI

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
