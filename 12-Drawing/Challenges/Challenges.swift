//
//  Challenges.swift
//  Drawing
//
//  Created by Eray Diler on 11.10.2023.
//

import SwiftUI

///
/// 1. Create an Arrow shape – having it point straight up is fine. 
///    This could be a rectangle/triangle-style arrow, or perhaps three lines, 
///    or maybe something else depending on what kind of arrow you want to draw.
/// 2. Make the line thickness of your Arrow shape animatable.
/// 3. Create a ColorCyclingRectangle shape that is the rectangular cousin of 
///    ColorCyclingCircle, allowing us to control the position of the gradient using one or more properties.
///

fileprivate enum Challenge: Int, CaseIterable {
    case first, second, third

    var title: String { String(rawValue + 1) }
}

struct Challenges: View {
    @State private var challenge: Challenge = .first

    var body: some View {
        VStack {
            Group {
                Section {
                    switch challenge {
                    case .first:
                        Challenge1()
                    case .second:
                        Challenge2()
                    case .third:
                        Challenge3()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Picker("Pick A Challenge", selection: $challenge) {
                    ForEach(Challenge.allCases, id: \.self) {
                        Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding([.top, .horizontal])
        }
    }
}

fileprivate struct Challenge1: View {
    var body: some View {
        Arrow()
            .stroke(
                .primary,
                style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
            )
    }
}

fileprivate struct Challenge2: View {
    @State private var lineWidth = 1.0

    var body: some View {
        VStack {
            Arrow()
                .stroke(
                    .primary,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
            Slider(value: $lineWidth.animation(), in: 1...10)
        }
    }
}

fileprivate struct Challenge3: View {
    @State private var amount = 0.0

    var body: some View {
        VStack {
            VStack {
                ColorCyclingRectangle(amount: amount)
                    .frame(width: 300, height: 300)
                    .drawingGroup()
            }
            .frame(maxHeight: .infinity)
            Slider(value: $amount)
        }
    }
}

#Preview {
    Challenges()
}
