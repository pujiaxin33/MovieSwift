//
//  FanClubNavigationDestinationModifier.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import SwiftUI

struct FanClubNavigationDestinationModifier: ViewModifier {
    let coordinator: FanClubCoordinator
    
    func body(content: Content) -> some View {
        return content
            .navigationDestination(for: Movie.self) { movie in
                coordinator.makeMovieDetailView(movie: movie)
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(for: MovieListPath.self, destination: { path in
                coordinator.makeMoviesListView(path: path)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: PeopleListPath.self, destination: { path in
                coordinator.makePeopleListView(path: path)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: People.self, destination: { people in
                coordinator.makePeopleDetailView(people: people)
                    .toolbar(.hidden, for: .tabBar)
            })
    }
}

extension View {
    func registerFanClubNavigationDestinations(with coordinator: FanClubCoordinator) -> some View {
        return ModifiedContent(content: self, modifier: FanClubNavigationDestinationModifier(coordinator: coordinator))
    }
}
