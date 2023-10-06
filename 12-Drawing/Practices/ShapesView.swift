//
//  ShapesView.swift
//  Drawing
//
//  Created by Eray Diler on 6.10.2023.
//

import SwiftUI

fileprivate struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

fileprivate struct Arc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: modifiedStartAngle,
            endAngle: modifiedEndAngle,
            clockwise: !clockwise
        )
        return path
    }
}

struct ShapesView: View {
    var body: some View {
        Triangle()
            .stroke(
                Color.blue,
                style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
            )

        Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            .stroke(
                .red,
                style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
            )
    }
}

#Preview {
    ShapesView()
}
