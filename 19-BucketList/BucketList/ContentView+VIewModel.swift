//
//  ContentView+VIewModel.swift
//  BucketList
//
//  Created by Eray Diler on 13.11.2023.
//

import Foundation
import LocalAuthentication
import _MapKit_SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var position: MapCameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
            )
        )
        @Published var visibleRegion: MKCoordinateRegion?
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published private(set) var locations = [Location]()

        private let savePath = URL.documentsDirectory.appendingPathComponent("com.BucketList.savedPlaces")

        init() {
            load()
        }

        private func load() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                print("Failed to load locations!")
            }
        }

        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Failed to encode locations!")
            }
        }

        func addLocation() {
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
            save()
        }

        func update(_ location: Location) {
            guard let place = selectedPlace else { return }

            if let index = locations.firstIndex(of: place) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()

            context.authenticate(reason: "Please authenticate yourself to unlock your places") {
                ///
                /// Task {
                ///    await MainActor.run {
                ///       self.isUnlocked = true
                ///    }
                /// }
                Task { @MainActor [weak self] in
                    self?.isUnlocked = true
                }
            } errorHandler: {
                print("Failed to authenticate.")
            }
        }
    }
}
