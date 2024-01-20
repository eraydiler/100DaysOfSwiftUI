//
//  AlertsAndSheetsWithOptionals.swift
//  SnowSeeker
//
//  Created by Eray Diler on 20.01.2024.
//

import SwiftUI

struct AlertsAndSheetsWithOptionals: View {
    private let notes = "Alerts and sheets for optionals"

    @State private var exampleViews: [AnyView] = [
        AnyView(Example1()),
        AnyView(Example2()),
        AnyView(Example3())
    ]

    var body: some View {
        Text(notes)
            .modifier(ExamplesViewModifier(exampleViews: exampleViews))
    }
}

fileprivate extension AlertsAndSheetsWithOptionals {
    struct User: Identifiable {
        var id = "Taylor Swift"
    }

    struct Example1: View {
        @State private var selectedUser: User? = nil

        var body: some View {
            Text("Hello, World!")
                .onTapGesture {
                    selectedUser = User()
                }
                .sheet(item: $selectedUser) { user in
                    Text(user.id)
                }
        }
    }

    struct Example2: View {
        @State private var selectedUser: User? = nil
        @State private var isShowingUser = false

        var body: some View {
            Text("Hello, World!")
                .onTapGesture {
                    selectedUser = User()
                    isShowingUser = true
                }
                .sheet(isPresented: $isShowingUser) {
                    Text(selectedUser?.id ?? "Unknown")
                }
        }
    }

    struct Example3: View {
        @State private var selectedUser: User? = nil
        @State private var isShowingUser = false

        var body: some View {
            Text("Hello, World!")
                .onTapGesture {
                    selectedUser = User()
                    isShowingUser = true
                }
                .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                    Button(user.id) { }
                }
//            .alert("Welcome", isPresented: $isShowingUser) {
//                Button("OK") { }
//            }
//            .alert("Welcome", isPresented: $isShowingUser) { }
        }
    }
}


#Preview {
    AlertsAndSheetsWithOptionals()
}
