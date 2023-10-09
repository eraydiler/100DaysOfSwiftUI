//
//  State.swift
//  iExpense
//
//  Created by Eray Diler on 29.09.2023.
//

import SwiftUI

extension StateView {
    private struct User {
        var firstName = "Bilbo"
        var lastName = "Baggins"
    }
}

struct FirstView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    FirstView()
}
