//
//  LocationDetailView.swift
//  PhotoLib
//
//  Created by Eray Diler on 7.12.2023.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    let location: Location

    @State private var position: MapCameraPosition

    init(location: Location) {
        self.location = location
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        )
        _position = State(initialValue: MapCameraPosition.region(region))
    }

    var body: some View {
        NavigationView {
            VStack {
                Map(position: $position) {
                    Marker("", coordinate: location.coordinate)
                }
            }
        }
    }
}
