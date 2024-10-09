//
//  MoviesListViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
import Observation
import Combine

@Observable
class MoviesListViewModel {
    enum ListType: Hashable {
        case menu(MoviesMenu)
        case genre(Genre)
        case local
        
        var showSearch: Bool {
            switch self {
            case .menu:
                return true
            case .genre:
                return false
            case .local:
                return false
            }
        }
    }
    
    let listType: MoviesListViewModel.ListType
    let repository: MoviesHomeRepository
    private(set) var movies: [Movie]
    private(set) var searchMovies: [Movie] = []
    private var bags: Set<AnyCancellable> = .init()
    
    init(listType: MoviesListViewModel.ListType, repository: MoviesHomeRepository, movies: [Movie]) {
        self.listType = listType
        self.repository = repository
        self.movies = movies
    }
    
    func searchMovies(with keyword: String) {
        switch listType {
        case .menu:
            repository
                .searchMovies(params: ["query": keyword, "page": "1"])
                .sink { _ in
                } receiveValue: { data in
                    self.searchMovies = data.results
                }
                .store(in: &bags)
        default: break
        }
    }
    
    func fetchMovies() {
        switch listType {
        case .menu(let moviesMenu):
            let region = Locale.current.region?.identifier ?? "US"
            repository.fetchMovies(menu: moviesMenu, params: ["page": "1", "region": region])
                .sink { _ in
                } receiveValue: { data in
                    self.movies = data.results
                }.store(in: &bags)
        case .genre(let genre):
            let params = ["with_genres": "\(genre.id)",
                          "page": "\(1)",
                          "sort_by": MoviesSort.byPopularity.sortByAPI()]
            repository.fetchDiscoverMovies(params: params)
                .sink { _ in
                } receiveValue: { data in
                    self.movies = data.results
                }.store(in: &bags)
        case .local:
            break
        }
    }
}
