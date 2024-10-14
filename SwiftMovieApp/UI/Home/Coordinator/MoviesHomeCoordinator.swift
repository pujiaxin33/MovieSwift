//
//  MoviesHomeCoordinator.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import SwiftUI

class MoviesHomeCoordinator {
    let repository: MoviesHomeRepository
    let peopleRepository: PeopleRepository
    let fanClubPeopleStorage: FanClubPeopleStorage
    let seenMoviesStorage: SeenMoviesStorage
    
    init(repository: MoviesHomeRepository, peopleRepository: PeopleRepository, fanClubPeopleStorage: FanClubPeopleStorage, seenMoviesStorage: SeenMoviesStorage) {
        self.repository = repository
        self.peopleRepository = peopleRepository
        self.fanClubPeopleStorage = fanClubPeopleStorage
        self.seenMoviesStorage = seenMoviesStorage
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(viewModel: .init(repository: repository, seenMoviesStorage: seenMoviesStorage, movie: movie))
    }
    
    func makeMoviesListView(path: MovieListPath) -> MoviesListView {
        return MoviesListView(
            viewModel: .init(listType: path.listType, repository: repository, peopleRepository: peopleRepository, movies: path.movies),
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
