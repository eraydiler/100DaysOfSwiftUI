//
//  InsettableShapes.swift
//  Drawing
//
//  Created by Eray Diler on 6.10.2023.
//

import SwiftUI

struct Arc2: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool

    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2 - insetAmount,
            startAngle: modifiedStartAngle,
            endAngle: modifiedEndAngle,
            clockwise: !clockwise
        )

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct InsettableShapes: View {
    var body: some View {
        Arc2(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
            .strokeBorder(.red, lineWidth: 40)
    }
}

#Preview {
    InsettableShapes()
}
