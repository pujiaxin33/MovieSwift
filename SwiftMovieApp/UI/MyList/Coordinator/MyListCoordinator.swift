//
//  MyListCoordinator.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/14.
//

import Foundation

class MyListCoordinator {
    let repository: MoviesHomeRepository
    let peopleRepository: PeopleRepository
    let fanClubPeopleStorage: FanClubPeopleStorage
    let seenMoviesStorage: SeenMoviesStorage
    let wishMoviesStorage: WishMoviesStorage
    
    init(
        repository: MoviesHomeRepository,
        peopleRepository: PeopleRepository,
        fanClubPeopleStorage: FanClubPeopleStorage,
        seenMoviesStorage: SeenMoviesStorage,
        wishMoviesStorage: WishMoviesStorage
    ) {
        self.repository = repository
        self.peopleRepository = peopleRepository
        self.fanClubPeopleStorage = fanClubPeopleStorage
        self.seenMoviesStorage = seenMoviesStorage
        self.wishMoviesStorage = wishMoviesStorage
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(
            viewModel: .init(
                repository: repository,
                seenMoviesStorage: seenMoviesStorage,
                wishMoviesStorage: wishMoviesStorage,
                movie: movie)
        )
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
