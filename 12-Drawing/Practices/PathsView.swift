//
//  PathsView.swift
//  Drawing
//
//  Created by Eray Diler on 6.10.2023.
//

import SwiftUI

struct PathsView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 200))
            path.addLine(to: CGPoint(x: 100, y: 400))
            path.addLine(to: CGPoint(x: 300, y: 400))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.closeSubpath()
        }
        .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

#Preview {
    PathsView()
}
