//
//  BookAdditionView.swift
//  Bookworm
//
//  Created by Eray Diler on 19.10.2023.
//

import SwiftUI

struct BookAdditionView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    @State private var showValidationAlert = false

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    StarRatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        saveBook()
                    }
                }
            }
            .autocorrectionDisabled()
            .navigationTitle("Add Book")
            .alert("Opps!", isPresented: $showValidationAlert) {
                Button("OK") { }
            } message: {
                Text("Please make sure you filled title and author fields")
            }
        }
    }
}

extension BookAdditionView {
    private var isFormValid: Bool {
        !title.isEmpty
        && !author.isEmpty
        && !genre.isEmpty
    }

    private func saveBook() {
        if !isFormValid {
            showValidationAlert.toggle()
            return
        }

        let newBook = Book(context: context)
        newBook.id = UUID()
        if !title.isEmpty {
            newBook.title = title
        }
        if !author.isEmpty {
            newBook.author = author
        }
        newBook.rating = Int16(rating)
        if !genre.isEmpty {
            newBook.genre = genre
        }
        if !review.isEmpty {
            newBook.review = review
        }

        newBook.creationDate = Date.now

        do {
            try context.save()
        } catch {
            print(error)
        }

        dismiss()
    }
}

#Preview {
    BookAdditionView()
}
