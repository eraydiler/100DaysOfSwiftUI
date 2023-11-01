//
//  onChangeModifier.swift
//  Instafilter
//
//  Created by Eray Diler on 30.10.2023.
//

import SwiftUI

struct onChangeModifier: View {
    @State private var blurAmount = 0.0 {
        /// Because of the way SwiftUI sends binding updates to property wrappers, assigning property observers used with property wrappers often won’t work, which means this kind of code won’t print anything even as the blur radius changes:
        didSet {
//            print("New value is \(blurAmount)")
        }
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        /// onChange() modifier, which tells SwiftUI to run a function of our choosing when a particular value changes. SwiftUI will automatically pass in the new value to whatever function you attach, or you can just read the original property if you prefer:
        .onChange(of: blurAmount) { oldValue, newValue in
            print("New value is \(blurAmount)")
        }
    }
}

#Preview {
    onChangeModifier()
}
