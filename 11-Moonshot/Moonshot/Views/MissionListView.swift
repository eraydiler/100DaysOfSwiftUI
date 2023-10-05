//
//  MissionListView.swift
//  Moonshot
//
//  Created by Eray Diler on 1.10.2023.
//

import SwiftUI

struct MissionListView: View {
    private enum DisplayMode {
        case grid, list
        
        mutating func toggle() {
            if self == .grid {
                self = .list
            } else {
                self = .grid
            }
        }
    }

    @State private var displayMode: DisplayMode = .list

    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationView {
            ScrollView {
                if displayMode == .grid {
                    GridListView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("") {
                    displayMode.toggle()
                }
                .buttonStyle(
                    NavBarButton(
                        systemImage: displayMode == .grid ? "list.bullet" : "circle.grid.2x2"
                    )
                )
            }
        }
    }
    
    fileprivate struct GridListView: View {
        fileprivate let missions: [Mission]
        fileprivate let astronauts: [String: Astronaut]
        private let columns = [GridItem(.adaptive(minimum: 150))]

        var body: some View {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionDetailView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionView(
                            image: mission.image,
                            displayName: mission.displayName,
                            launchDate: mission.formattedLaunchDate
                        )
                    }
                }
            }
            .padding()
        }
    }

    fileprivate struct ListView: View {
        fileprivate let missions: [Mission]
        fileprivate let astronauts: [String: Astronaut]

        var body: some View {
            LazyVStack(spacing: 10) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionDetailView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionView(
                            image: mission.image,
                            displayName: mission.displayName,
                            launchDate: mission.formattedLaunchDate
                        )
                    }
                }
            }
        }
    }

    fileprivate struct MissionView: View {
        let image: String
        let displayName: String
        let launchDate: String

        var body: some View {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                VStack {
                    Text(displayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(launchDate)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            }
        }
    }
}

struct NavBarButton: ButtonStyle {
    var systemImage: String = ""

    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: systemImage)
            .foregroundStyle(.white)
    }
}

#Preview {
    MissionListView()
}
