//
//  DrawingGroups.swift
//  Drawing
//
//  Created by Eray Diler on 9.10.2023.
//

import SwiftUI

protocol ColorCyclingCircle: View {
    var amount: Double { get }
    var steps: Int { get }

    func color(for value: Int, brightness: Double) -> Color
}

extension ColorCyclingCircle {
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingCircle1: ColorCyclingCircle {
    var amount = 0.0
    var steps = 100
}

struct ColorCyclingCircle2: ColorCyclingCircle {
    var amount = 0.0
    var steps = 100
}

struct DrawingGroups: View {
    @State private var colorCycle1 = 0.0
    @State private var colorCycle2 = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle1(amount: colorCycle1)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle1)

            ColorCyclingCircle2(amount: colorCycle2)
                .frame(width: 300, height: 300)
                .drawingGroup()

            Slider(value: $colorCycle2)
        }
    }
}

#Preview {
    DrawingGroups()
}
