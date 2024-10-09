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
    let fanClubPeopleStorage: FanClubPeopleStorage
    
    init(moviesRepository: MoviesHomeRepository, 
         fanClubRepository: FanClubRepository,
         peopleRepository: PeopleRepository,
         fanClubPeopleStorage: FanClubPeopleStorage
    ) {
        self.moviesRepository = moviesRepository
        self.fanClubRepository = fanClubRepository
        self.peopleRepository = peopleRepository
        self.fanClubPeopleStorage = fanClubPeopleStorage
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(viewModel: .init(repository: moviesRepository, movie: movie))
    }
    
    func makeMoviesListView(path: MovieListPath) -> MoviesListView {
        return MoviesListView(viewModel: .init(repository: moviesRepository, movies: path.movies), naviTitle: path.naviTitle, displaySearch: true)
    }
    
    func makePeopleListView(path: PeopleListPath) -> PeopleListView {
        return PeopleListView(naviTitle: path.naviTitle, peoples: path.peoples)
    }
    
    func makePeopleDetailView(people: People) -> PeopleDetailView {
        return PeopleDetailView(viewModel: .init(repository: peopleRepository, storage: fanClubPeopleStorage, people: people))
    }
    
    func makeMoviesGenreListView(genre: Genre) -> MoviesGenreListView {
        return MoviesGenreListView(viewModel: .init(repository: moviesRepository, genre: genre))
    }
}
