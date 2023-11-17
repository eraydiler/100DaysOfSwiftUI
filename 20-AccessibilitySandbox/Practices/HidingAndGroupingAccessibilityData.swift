//
//  HidingAndGroupingAccessibilityData.swift
//  AccessibilitySandbox
//
//  Created by Eray Diler on 16.11.2023.
//

import SwiftUI

struct HidingAndGroupingAccessibilityData: View {
    var body: some View {
        
        // Image(decorative:) tells SwiftUI it should be ignored by VoiceOver.
        Image(decorative: "character")

        //  Makes any view completely invisible to the accessibility system
            .accessibilityHidden(true)

        // VoiceOver sees that as two unrelated text views, and so it will either read “Your score is” or “1000” depending on what the user has selected. Both of those are unhelpful, which is where the .accessibilityElement(children:) modifier comes in: we can apply it to a parent view, and ask it to combine children into a single accessibility element.

        // This will cause both text views to be read together:
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        // When the child views contain separate information
        .accessibilityElement(children: .combine)

        // When it should be read as a single entity.
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    HidingAndGroupingAccessibilityData()
}
