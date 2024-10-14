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
        case keyword(String)
        
        var showSearch: Bool {
            switch self {
            case .menu:
                return true
            case .genre:
                return false
            case .local:
                return false
            case .keyword:
                return false
            }
        }
    }
    
    let listType: MoviesListViewModel.ListType
    let repository: MoviesRepository
    let peopleRepository: PeopleRepository
    private(set) var movies: [Movie]
    private(set) var searchMovies: [Movie] = []
    private(set) var searchKeywords: [Keyword] = []
    private(set) var searchPeoples: [People] = []
    private var bags: Set<AnyCancellable> = .init()
    
    init(listType: MoviesListViewModel.ListType, repository: MoviesRepository, peopleRepository: PeopleRepository, movies: [Movie]) {
        self.listType = listType
        self.repository = repository
        self.peopleRepository = peopleRepository
        self.movies = movies
    }
    
    func searchMovies(with keyword: String) {
        guard listType.showSearch else { return }
        repository
            .searchMovies(params: ["query": keyword, "page": "1"])
            .sink { _ in
            } receiveValue: { data in
                self.searchMovies = data.results
            }
            .store(in: &bags)
        
        peopleRepository
            .searchPeoples(params: ["query": keyword, "page": "1"])
            .sink { _ in
            } receiveValue: { data in
                self.searchPeoples = data.results
            }
            .store(in: &bags)
        
        repository
            .searchKeywords(params: ["query": keyword])
            .sink { _ in
            } receiveValue: { data in
                self.searchKeywords = data.results
            }
            .store(in: &bags)
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
        case .keyword(let keyword):
            let params = ["with_keywords": keyword,
                          "page": "\(1)",
                          "sort_by": MoviesSort.byPopularity.sortByAPI()]
            repository.fetchDiscoverMovies(params: params)
                .sink { _ in
                } receiveValue: { data in
                    self.movies = data.results
                }.store(in: &bags)
        }
    }
    
    func resetSearchData() {
        searchKeywords = []
        searchMovies = []
        searchPeoples = []
    }
}
