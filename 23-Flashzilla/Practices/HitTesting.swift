//
//  HitTesting.swift
//  Flashzilla
//
//  Created by Eray Diler on 18.12.2023.
//

import SwiftUI

struct HitTestingView: View {
    var body: some View {
        ZStack {

//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//            ---
//                .allowsHitTesting(false)
//            ---
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//            ---
//            VStack {
//                Text("Hello")
//                Spacer().frame(height: 100)
//                Text("World")
//            }
//            .onTapGesture {
//                print("VStack tapped!")
//            }
//            ---
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }

        }
    }
}

#Preview {
    HitTestingView()
}
