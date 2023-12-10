//
//  ImageInterpolation.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SwiftUI

struct ImageInterpolationView: View {
    var body: some View {
        Image("example")
            .interpolation(.none) // to prevent blurriness
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()   
    }
}

#Preview {
    ImageInterpolationView()
}
