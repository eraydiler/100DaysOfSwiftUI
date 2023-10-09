//
//  ImagePaints.swift
//  Drawing
//
//  Created by Eray Diler on 9.10.2023.
//

import SwiftUI

struct ImagePaints: View {
    var body: some View {
        Capsule()
            .strokeBorder(
                ImagePaint(image: Image("Example"), scale: 0.1),
                lineWidth: 20
            )
            .frame(width: 300, height: 200)
    }
}

#Preview {
    ImagePaints()
}
