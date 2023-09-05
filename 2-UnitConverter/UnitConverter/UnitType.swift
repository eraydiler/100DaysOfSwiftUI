//
//  Conversion.swift
//  UnitConverter
//
//  Created by Eray Diler on 4.09.2023.
//

import Foundation

protocol UnitType {
    var name: String { get }
    var units: [Unit] { get }
}

struct Unit {
    var name: String
    var unit: Dimension
}

struct Temperature: UnitType {
    var name: String = "Temperature"
    var units: [Unit] = [
        .init(name: "Celcius", unit: UnitTemperature.celsius),
        .init(name: "Fahreneit", unit: UnitTemperature.fahrenheit),
        .init(name: "Kelvin", unit: UnitTemperature.kelvin)
    ]
}

struct Length: UnitType {
    var name: String = "Length"
    var units: [Unit] = [
        .init(name: "Meters", unit: UnitLength.meters),
        .init(name: "Kilometers", unit: UnitLength.kilometers),
        .init(name: "Feet", unit: UnitLength.feet),
        .init(name: "Yards", unit: UnitLength.yards),
        .init(name: "Miles", unit: UnitLength.miles)
    ]
}

struct Time: UnitType {
    var name: String = "Time"
    var units: [Unit] = [
        .init(name: "Seconds", unit: UnitDuration.seconds),
        .init(name: "Minutes", unit: UnitDuration.minutes),
        .init(name: "Hours", unit: UnitDuration.hours)
    ]
}

struct Volume: UnitType {
    var name: String = "Volume"
    var units: [Unit] = [
        .init(name: "Milimeters", unit: UnitVolume.milliliters),
        .init(name: "Liters", unit: UnitVolume.liters),
        .init(name: "Cups", unit: UnitVolume.cups),
        .init(name: "Pints", unit: UnitVolume.pints),
        .init(name: "Gallons", unit: UnitVolume.gallons)
    ]
}
