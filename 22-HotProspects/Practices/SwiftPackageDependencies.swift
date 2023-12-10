//
//  SwiftPackageDependencies.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import SamplePackage
import SwiftUI

struct SwiftPackageDependenciesView: View {
    let possibleNumbers = Array(1...60)

    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        Text(results)
    }
}

#Preview {
    SwiftPackageDependenciesView()
}
