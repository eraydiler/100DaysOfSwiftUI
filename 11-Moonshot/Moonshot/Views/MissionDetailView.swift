//
//  MissionDetailView.swift
//  Moonshot
//
//  Created by Eray Diler on 4.10.2023.
//

import SwiftUI

struct MissionDetailView: View {
    fileprivate struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    private let mission: Mission
    private let crewMembers: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crewMembers = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Astronaut not found!")
            }

            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    Text(mission.formattedLaunchDate)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        CustomDivider()

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        CustomDivider()

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    CrewMembersView(crewMembers: crewMembers, width: geometry.size.width )
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

extension MissionDetailView {
    struct CrewMembersView: View {
        fileprivate let crewMembers: [CrewMember]
        fileprivate let width: CGFloat

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crewMembers, id: \.role) { member in
                        NavigationLink {
                            AstranoutDetailView(astronaut: member.astronaut)
                        } label: {
                            HStack {
                                Image(member.astronaut.id)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width * 0.33)
                                    .clipShape(Capsule())
                                    .overlay {
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    }

                                VStack(alignment: .leading) {
                                    Text(member.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text(member.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)

        }
    }
}

fileprivate struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionDetailView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
