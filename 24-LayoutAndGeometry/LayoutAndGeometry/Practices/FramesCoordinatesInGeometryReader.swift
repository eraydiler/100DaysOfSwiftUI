//
//  FramesCoordinatesInGeometryReader.swift
//  LayoutAndGeometry
//
//  Created by Eray Diler on 28.12.2023.
//

import SwiftUI

fileprivate struct Example1View: View {
    var body: some View {
        GeometryReader { geo in
            Text("Hello, World!")
                .frame(width: geo.size.width * 0.9)
                .background(.red)
        }
    }
}

fileprivate struct Example2View: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }

            Text("More text")
                .background(.blue)
        }
    }
}

fileprivate struct Example3View: View {
    struct OuterView: View {
        var body: some View {
            VStack {
                Text("Top")
                InnerView()
                    .background(.green)
                Text("Bottom")
            }
        }
    }

    struct InnerView: View {
        var body: some View {
            HStack {
                Text("Left")
                GeometryReader { geo in
                    Text("Center")
                        .background(.blue)
                        .onTapGesture {
//                            print(
//                                "Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)"
//                            )
//                            print(
//                                "Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)"
//                            )
//                            print(
//                                "Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)"
//                            )
                            print(
                                "Global frame: \(geo.frame(in: .global).size.width) x \(geo.frame(in: .global).size.height)"
                            )
                            print(
                                "Local frame: \(geo.frame(in: .local).size.width) x \(geo.frame(in: .local).size.height)"
                            )
                            print(
                                "Custom frame: \(geo.frame(in: .named("Custom")).size.width) x \(geo.frame(in: .named("Custom")).size.height)"
                            )
                        }
                }
                .background(.orange)
                Text("Right")
            }
        }
    }

    var body: some View {
        GeometryReader { geo in
            OuterView()
                .background(.red)
                .coordinateSpace(name: "Custom")
            let _ = print(
                "Global frame: \(geo.frame(in: .global).size.width) x \(geo.frame(in: .global).size.height)"
            )

        }
    }
}

struct FramesCoordinatesInGeometryReaderView: View {
    var body: some View {
//        Example1View()
//        Example2View()
        Example3View()
    }
}

#Preview {
    FramesCoordinatesInGeometryReaderView()
}
