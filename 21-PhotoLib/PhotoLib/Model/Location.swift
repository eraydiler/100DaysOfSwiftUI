//
//  Location.swift
//  PhotoLib
//
//  Created by Eray Diler on 7.12.2023.
//

import CoreLocation

struct Location {
    let coordinate: CLLocationCoordinate2D
    let latitude: Double
    let longitude: Double

    var isAvailable: Bool {
        longitude != .zero || latitude != .zero
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }

    init(latitude: Double, longitude: Double) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
