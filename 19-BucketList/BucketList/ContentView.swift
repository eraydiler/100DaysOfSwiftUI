//
//  ContentView.swift
//  BucketList
//
//  Created by Eray Diler on 6.11.2023.
//

import MapKit
import SwiftUI

///
/// For the newest apis
/// https://www.wwdcnotes.com/notes/wwdc23/10043/
///
/// Challenge
/// 1. Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does
///   it make, and can you think why?
/// 2. Our app silently fails when errors occur during biometric authentication, so add code to show those errors in an alert.
/// 3. Create another view model, this time for EditView. What you put in the view model is down to you,
///   but I would recommend leaving dismiss and onSave in the view itself – the former uses the environment,
///   which can only be read by the view, and the latter doesn’t really add anything when moved into the model.
///
struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var isPresentingErrorAlert = false
    @State private var authenticationErrorMessage = "There was a problem while authenticating"

    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(position: $viewModel.position) {
                    ForEach(viewModel.locations) { location in
                        Annotation("", coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())

                                Text(location.name)
                            }
                            .onTapGesture {
                                viewModel.selectedPlace = location
                            }
                        }
                    }
                }
                .onMapCameraChange { context in
                    viewModel.visibleRegion = context.region
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
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
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
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(newLocation)
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate { error in
                    if let error = error {
                        authenticationErrorMessage = error
                    }
                    isPresentingErrorAlert = true
                }
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Authentication Failed", isPresented: $isPresentingErrorAlert) {
                Button("OK") { }
            } message: {
                Text(authenticationErrorMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
