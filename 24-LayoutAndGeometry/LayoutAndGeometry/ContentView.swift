//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Eray Diler on 27.12.2023.
//

import SwiftUI

/**
    Challenges

    1. Make views near the top of the scroll view fade out to 0
       opacity – I would suggest starting at about 200 points from the top.
    2. Make views adjust their scale depending on their vertical
       position, with views near the bottom being large and views near the top being small. I would suggest going no smaller than 50% of the regular size.
    3. For a real challenge make the views change color as you
       scroll. For the best effect, you should create colors using the Color(hue:saturation:brightness:) initializer, feeding in varying values for the hue.
 */

struct ContentView: View {
    var body: some View {
        GeometryReader { screenGeo in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { rowGeo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(calculatedColorFor(screenGeo: screenGeo, rowGeo: rowGeo))
                            .rotation3DEffect(
                                .degrees(rowGeo.frame(in: .global).minY - screenGeo.size.height / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(
                                rowGeo.frame(in: .global).minY < 200
                                    ? rowGeo.frame(in: .global).minY / 200
                                    : 1
                            )
                            .scaleEffect(
                                CGSize(
                                    width: calculatedWidthFor(screenGeo: screenGeo, rowGeo: rowGeo),
                                    height: 1.0
                                )
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }

    private func normalizedValueFor(x: Double, y: Double) -> Double {
        (x - y) / x
    }

    private func calculatedWidthFor(screenGeo: GeometryProxy, rowGeo: GeometryProxy) -> CGFloat {
        // Calculate the normalized position of the row's bottom edge within the screen's height
        let normalizedY = normalizedValueFor(
            x: screenGeo.frame(in: .global).maxY,
            y: rowGeo.frame(in: .global).maxY
        )
        
        // Map the normalized position to a scale value between 1 (bottom) and 0.5 (top)
        return 1 - normalizedY * 0.5
    }

    private func calculatedColorFor(screenGeo: GeometryProxy, rowGeo: GeometryProxy) -> Color {
        let normalizedY = normalizedValueFor(
            x: screenGeo.frame(in: .global).maxY,
            y: rowGeo.frame(in: .global).maxY
        )
        // Map the normalized position to a scale value between 1 (bottom) and 0.5 (top)
        let hue =  1 - normalizedY

        return Color(hue: hue, saturation: 1, brightness:1)
    }
}

#Preview {
    ContentView()
}
