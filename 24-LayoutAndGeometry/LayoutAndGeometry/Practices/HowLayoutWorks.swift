//
//  HowLayoutWorks.swift
//  LayoutAndGeometry
//
//  Created by Eray Diler on 27.12.2023.
//

import SwiftUI

/**

    The three step layout process of SwiftUI.

    1. A parent view proposes a size for its child.
    2. Based on that information, the child then chooses its own size and the parent must respect that choice.
    3. The parent then positions the child in its coordinate space.

 */

struct HowLayoutWorksView: View {
    var body: some View {
        /**
         * HowLayoutWorksView offers the frame the whole screen.
         * The backgrond sends the whole screen the frame.
         * The frame reports back that it wants 300x300.
         * The frame then asks the text inside it what size it wants.
         * The text choeses X pixels width by Y pixels height, that is needed for its content.
         * The frame then positions the text in the center of itself.
         */
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(.red)
    }
}

#Preview {
    HowLayoutWorksView()
}
