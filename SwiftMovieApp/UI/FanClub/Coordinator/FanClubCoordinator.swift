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
    let seenMoviesStorage: SeenMoviesStorage
    
    init(moviesRepository: MoviesHomeRepository, 
         fanClubRepository: FanClubRepository,
         peopleRepository: PeopleRepository,
         fanClubPeopleStorage: FanClubPeopleStorage,
         seenMoviesStorage: SeenMoviesStorage
    ) {
        self.moviesRepository = moviesRepository
        self.fanClubRepository = fanClubRepository
        self.peopleRepository = peopleRepository
        self.fanClubPeopleStorage = fanClubPeopleStorage
        self.seenMoviesStorage = seenMoviesStorage
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(viewModel: .init(repository: moviesRepository, seenMoviesStorage: seenMoviesStorage, movie: movie))
    }
    
    func makeMoviesListView(path: MovieListPath) -> MoviesListView {
        return MoviesListView(
            viewModel: .init(listType: path.listType, repository: moviesRepository, peopleRepository: peopleRepository, movies: path.movies),
            naviTitle: path.naviTitle
        )
    }
    
    func makePeopleListView(path: PeopleListPath) -> PeopleListView {
        return PeopleListView(naviTitle: path.naviTitle, peoples: path.peoples)
    }
    
    func makePeopleDetailView(people: People) -> PeopleDetailView {
        return PeopleDetailView(viewModel: .init(repository: peopleRepository, storage: fanClubPeopleStorage, people: people))
    }
}
