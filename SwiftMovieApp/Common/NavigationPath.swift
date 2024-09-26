//
//  NavigationPath.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import Foundation
import SwiftUI

struct NavigationDestinationModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(viewModel: .init(movie: movie))
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(for: MovieListPath.self, destination: { path in
                MoviesListView(naviTitle: path.naviTitle, movies: path.movies)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: PeopleListPath.self, destination: { path in
                PeopleListView(naviTitle: path.naviTitle, peoples: path.peoples)
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: People.self, destination: { people in
                PeopleDetailView(viewModel: .init(people: people))
                    .toolbar(.hidden, for: .tabBar)
            })
            .navigationDestination(for: Genre.self, destination: { genre in
                MoviesGenreListView(viewModel: .init(genre: genre))
                    .toolbar(.hidden, for: .tabBar)
            })
    }
}

extension View {
    func registerNavigationDestinations() -> some View {
        ModifiedContent(content: self, modifier: NavigationDestinationModifier())
    }
}

@Observable
final class Navigation {
    var path = NavigationPath()
}

extension EnvironmentValues {
    private struct NavigationKey: EnvironmentKey {
        static let defaultValue = Navigation()
    }

    var navigation: Navigation {
        get { self[NavigationKey.self] }
        set { self[NavigationKey.self] = newValue }
    }
}

struct MovieListPath: Hashable {
    let naviTitle: String
    let movies: [Movie]
}

struct PeopleListPath: Hashable {
    let naviTitle: String
    let peoples: [People]
}
