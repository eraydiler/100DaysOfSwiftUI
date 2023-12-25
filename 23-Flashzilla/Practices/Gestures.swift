//
//  Gestures.swift
//  Flashzilla
//
//  Created by Eray Diler on 18.12.2023.
//

import SwiftUI

fileprivate struct MagnificationModifier: ViewModifier {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0

    func body(content: Content) -> some View {
        Text("Hello, World!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

fileprivate struct RotationModifier: ViewModifier {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero

    func body(content: Content) -> some View {
        Text("Hello, World!")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
            )
    }
}

fileprivate struct GestureSequenceModifier: ViewModifier {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    func body(content: Content) -> some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct GesturesView: View {
    var body: some View {
        Text("Hello, World!")
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
//            .onLongPressGesture {
//                print("Long pressed!")
//            }
//            .onLongPressGesture(minimumDuration: 2) {
//                print("Long pressed!")
//            }
//            .onLongPressGesture(minimumDuration: 1) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)!")
//            }
//            .modifier(MagnificationModifier())
//            .modifier(RotationModifier())

//        Multiple gestures
//        VStack {
//            Text("Hello, World!")
//                .onTapGesture {
//                    print("Text tapped")
//                }
//        }
//        .onTapGesture {
//            print("VStack tapped")
//        }
//        ---
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded { _ in
//                    print("VStack tapped")
//                }
//        )
//        ---
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded { _ in
//                    print("VStack tapped")
//                }
//        )
//        ---
        .modifier(GestureSequenceModifier())
    }
}

#Preview {
    GesturesView()
}
