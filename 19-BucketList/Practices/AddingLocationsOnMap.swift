//
//  AddingLocationsOnMap.swift
//  BucketList
//
//  Created by Eray Diler on 9.11.2023.
//

import MapKit
import SwiftUI

///
/// I followed relevant the WWDC notes to use up-to-date apis
/// https://www.wwdcnotes.com/notes/wwdc23/10043/
///

struct AddingLocationsOnMap: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
    )
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var locations = [Location]()

    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(locations) { location in
//                    Marker(location.name, coordinate: location.coordinate)
                    Annotation(location.name, coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())

                            Text(location.name)
                        }
                    }
                }
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
            .ignoresSafeArea()

            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        createNewLocation()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
    }
}

extension AddingLocationsOnMap {
    private func createNewLocation() {
        print(position)
        guard
            let latitude = visibleRegion?.center.latitude,
            let longitude = visibleRegion?.center.longitude
        else { return }

        let newLocation = Location(
            id: UUID(),
            name: "New location",
            description: "",
            latitude: latitude,
            longitude: longitude
        )
        locations.append(newLocation)
    }
}

#Preview {
    AddingLocationsOnMap()
}
