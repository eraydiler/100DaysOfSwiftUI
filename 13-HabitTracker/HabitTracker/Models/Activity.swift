//
//  Activity.swift
//  HabitTracker
//
//  Created by Eray Diler on 13.10.2023.
//

import Foundation
import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var description: String
    var numberOfCompletion: Int
    let creationDate: Date

    var formattedNumberOfDescription: String {
        if numberOfCompletion == 0 {
            return "Not started"
        } else {
            return "\(numberOfCompletion) times"
        }
    }

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        numberOfCompletion: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.numberOfCompletion = numberOfCompletion
        self.creationDate = Date()
    }
}

extension Activity: Mockable {
    static func generateMockedItems(_ numberOfActivities: Int) -> [Activity] {
        var activities: [Activity] = []
        for i in 0...numberOfActivities - 1 {
            activities.append(
                Activity(
                    title: "Activity\(i + 1)",
                    description: "Desc\(i + 1)",
                    numberOfCompletion: 0
                )
            )
        }
        return activities
    }
}

extension Activity {
    var preferredColor: Color {
        let color: Color

        if numberOfCompletion < 1 {
            color = Color.red
        } else if numberOfCompletion < 2 {
            color = Color.orange
        } else if numberOfCompletion < 3 {
            color = Color.yellow
        } else if numberOfCompletion < 4 {
            color = Color.green
        } else if numberOfCompletion < 5 {
            color = Color.mint
        } else if numberOfCompletion < 6 {
            color = Color.teal
        } else if numberOfCompletion < 7 {
            color = Color.cyan
        } else {
            color = Color.blue
        }

        return color
    }
}
