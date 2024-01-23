//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Eray Diler on 20.01.2024.
//

import SwiftUI

/**
    Challenges:
    1. Add a photo credit over the ResortView image. The data is already loaded from the
       JSON for this purpose, so you just need to make it look good in the UI.
    2. Fill in the loading and saving methods for Favorites.
    3. For a real challenge, let the user sort the resorts in ContentView either using the
       default order, alphabetical order, or country order.
 */

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @StateObject var favorites = Favorites()
    @State private var showingPopover = false
    @State private var sorting = Sorting(type: .alphabetical)

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }

                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sort By") {
                        showingPopover.toggle()
                    }
                    .popover(isPresented: $showingPopover) {
                        VStack {
                            Group {
                                Button("Alphabetical") {
                                    sortBy(.alphabetical)
                                }
                                .foregroundColor(sorting.buttonColorFor(.alphabetical))

                                Button("Country") {
                                    sortBy(.countryName)
                                }
                                .foregroundColor(sorting.buttonColorFor(.countryName))
                                
                                Button("Size") {
                                    sortBy(.size)
                                }
                                .foregroundColor(sorting.buttonColorFor(.size))

                                Button("Price") {
                                    sortBy(.price)
                                }
                                .foregroundColor(sorting.buttonColorFor(.price))
                            }
                            .font(.body)
                            .padding(.horizontal)
                            .padding(.top, 1)
                        }
                        .padding()
                        .presentationCompactAdaptation((.popover))
                    }
                    .onAppear { sortBy(.alphabetical) }
                }
            }

            WelcomeView()
        }
        .environmentObject(favorites)
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func sortBy(_ type: SortType) {
        sorting.type = type

        switch type {
        case .alphabetical:
            resorts.sort { $0.name < $1.name }
        case .countryName:
            resorts.sort { $0.country < $1.country }
        case .size:
            resorts.sort { $0.size < $1.size }
        case .price:
            resorts.sort { $0.price < $1.price }
        }
    }
}

#Preview {
    ContentView()
}
