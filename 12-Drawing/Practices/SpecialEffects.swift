//
//  SpecialEffects.swift
//  Drawing
//
//  Created by Eray Diler on 10.10.2023.
//

import SwiftUI

struct SpecialEffects: View {
    @State private var amount = 0.0
    @State private var isOn: Bool = false

    var body: some View {
        VStack {
            Group {
                if isOn {
                    BlendModeExample()
                } else {
                    SaturationBlurExample()
                }
            }
            Toggle(isOn: $isOn) {
                Text("Switch Example")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .tint(.orange)
        }
        .background(.black)
    }

    func BlendModeExample() -> some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(maxHeight: .infinity)

            Slider(value: $amount)
                .padding()
        }
    }

    func SaturationBlurExample() -> some View {
        VStack {
            Image("Example")
                .resizable()
                .scaledToFill()
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)

            Slider(value: $amount)
                .padding()
        }
    }
}

#Preview {
    SpecialEffects()
}
