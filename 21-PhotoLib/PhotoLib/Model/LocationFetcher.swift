//
//  LocationFetcher.swift
//  PhotoLib
//
//  Created by Eray Diler on 8.12.2023.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: Location?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        if manager.authorizationStatus != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let coordinate = locations.first?.coordinate {
            lastKnownLocation = Location(coordinate: coordinate)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
