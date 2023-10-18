//
//  AlertModifier.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 18.10.2023.
//

import SwiftUI

struct Alert {
    var isPresented: Bool = false
    var title: String = ""
    var message: String = ""
    var buttonTitle = "OK"
}

struct AlertModifier: ViewModifier {
    @Binding var alert: Alert

    func body(content: Content) -> some View {
        content.alert(
            alert.title,
            isPresented: $alert.isPresented) {
                Button(alert.buttonTitle) { }
            } message: {
                Text(alert.message)
            }
    }
}

extension View {
    func alert(_ alert: Binding<Alert>) -> some View {
        self.modifier(AlertModifier(alert: alert))
    }
}

