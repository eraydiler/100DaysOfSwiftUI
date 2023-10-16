//
//  FormValidation.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 16.10.2023.
//

import SwiftUI

struct FormValidation: View {
    @State private var username = ""
    @State private var email = ""

    private var isFormValid: Bool {
        username.count >= 5 && email.count >= 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(!isFormValid)
        }
    }
}

#Preview {
    FormValidation()
}
