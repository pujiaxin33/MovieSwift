//
//  MoviesNavigationDestinationModifier.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import SwiftUI

struct MoviesNavigationDestinationModifier: ViewModifier {
    let coordinator: MoviesHomeCoordinator
    
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
    func registerMoviesNavigationDestinations(with coordinator: MoviesHomeCoordinator) -> some View {
        return ModifiedContent(content: self, modifier: MoviesNavigationDestinationModifier(coordinator: coordinator))
    }
}
