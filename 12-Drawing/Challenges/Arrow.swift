//
//  Arrow.swift
//  Drawing
//
//  Created by Eray Diler on 11.10.2023.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX * 0.3, y: rect.maxY * 0.1))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY * 0.03))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        path.addLine(to: CGPoint(x: rect.maxX * 0.7, y: rect.maxY * 0.1))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY * 0.03))

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.8))
        path.addLine(to: CGPoint(x: rect.maxX * 0.43, y: rect.maxY * 0.9))
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.8))
        path.addLine(to: CGPoint(x: rect.maxX * 0.57, y: rect.maxY * 0.9))

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.85))
        path.addLine(to: CGPoint(x: rect.maxX * 0.43, y: rect.maxY * 0.95))
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.85))
        path.addLine(to: CGPoint(x: rect.maxX * 0.57, y: rect.maxY * 0.95))

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.9))
        path.addLine(to: CGPoint(x: rect.maxX * 0.43, y: rect.maxY * 1))
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.9))
        path.addLine(to: CGPoint(x: rect.maxX * 0.57, y: rect.maxY * 1))

        path.closeSubpath()

        return path
    }
}
