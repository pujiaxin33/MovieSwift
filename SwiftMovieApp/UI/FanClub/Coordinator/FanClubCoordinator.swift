//
//  FanClubCoordinator.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import SwiftUI

class FanClubCoordinator {
    let moviesRepository: MoviesHomeRepository
    let fanClubRepository: FanClubRepository
    let peopleRepository: PeopleRepository
    
    init(moviesRepository: MoviesHomeRepository, fanClubRepository: FanClubRepository, peopleRepository: PeopleRepository) {
        self.moviesRepository = moviesRepository
        self.fanClubRepository = fanClubRepository
        self.peopleRepository = peopleRepository
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(viewModel: .init(repository: moviesRepository, movie: movie))
    }
    
    func makeMoviesListView(path: MovieListPath) -> MoviesListView {
        return MoviesListView(naviTitle: path.naviTitle, movies: path.movies)
    }
    
    func makePeopleListView(path: PeopleListPath) -> PeopleListView {
        return PeopleListView(naviTitle: path.naviTitle, peoples: path.peoples)
    }
    
    func makePeopleDetailView(people: People) -> PeopleDetailView {
        return PeopleDetailView(viewModel: .init(repository: peopleRepository, people: people))
    }
    
    func makeMoviesGenreListView(genre: Genre) -> MoviesGenreListView {
        return MoviesGenreListView(viewModel: .init(repository: moviesRepository, genre: genre))
    }
}
