//
//  BedtimeCalculator.swift
//  BetterRest
//
//  Created by Eray Diler on 18.09.2023.
//

import CoreML
import Foundation

struct BedtimeCalculator {
    func getPredictedSleepTimeFrom(
        wakeUpTime: Date,
        sleepAmount: Double,
        coffeeAmount: Int
    ) throws -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepTimeCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(
                wake: Double (hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            return wakeUpTime - prediction.actualSleep
        } catch {
            throw error
        }
    }
}
