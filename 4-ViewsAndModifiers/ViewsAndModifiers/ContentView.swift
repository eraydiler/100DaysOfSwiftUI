//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Eray Diler on 8.09.2023.
//

/*
  Day23-24: Project 3
  https://www.hackingwithswift.com/100/swiftui/24
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)

            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(Color.red)
        }
    }
}

#Preview {
    ContentView()
}
