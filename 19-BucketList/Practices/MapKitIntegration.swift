//
//  MapKitIntegration.swift
//  BucketList
//
//  Created by Eray Diler on 8.11.2023.
//

import MapKit
import SwiftUI

struct MapKitIntegration: View {
    fileprivate struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }

    private let mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    private let locations = [
        Location(
            name: "Buckingham Palace",
            coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)
        ),
        Location(
            name: "Tower of London",
            coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)
        )
    ]

    var body: some View {
        NavigationView {
            Map(bounds: MapCameraBounds(centerCoordinateBounds: mapRegion)) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        NavigationLink {
                            Text(location.name)
                        } label: {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 44, height: 44)
                        }
                    }
                }
            }
            .navigationTitle("London Explorer")
        }
    }
}

#Preview {
    MapKitIntegration()
}
