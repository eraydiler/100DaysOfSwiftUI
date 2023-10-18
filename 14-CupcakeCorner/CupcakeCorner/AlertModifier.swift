//
//  AlertModifier.swift
//  CupcakeCorner
//
//  Created by Eray Diler on 18.10.2023.
//

import SwiftUI

struct Alert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    var buttonTitle = "OK"

    func body(content: Content) -> some View {
        content.alert(
            title,
            isPresented: $isPresented) {
                Button(buttonTitle) { }
            } message: {
                Text(message)
            }
    }
}

extension View {
    func alert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        buttonTitle: String = "OK"
    ) -> some View {
        return self.modifier(
            Alert(
                isPresented: isPresented,
                title: title,
                message: message,
                buttonTitle: buttonTitle
            )
        )
    }
}

