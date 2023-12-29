//
//  CustomAlignmentGuides.swift
//  LayoutAndGeometry
//
//  Created by Eray Diler on 27.12.2023.
//

import SwiftUI

fileprivate extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuidesView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
            }

            VStack {
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    CustomAlignmentGuidesView()
}
