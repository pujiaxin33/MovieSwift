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
    let repository: MoviesHomeRepository
    private(set) var movies: [Movie]
    private(set) var searchMovies: [Movie] = []
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: MoviesHomeRepository, movies: [Movie]) {
        self.repository = repository
        self.movies = movies
    }
    
    func searchMovies(with keyword: String) {
        repository
            .searchMovies(params: ["query": keyword, "page": "1"])
            .sink { _ in
                
            } receiveValue: { data in
                self.searchMovies = data.results
            }
            .store(in: &bags)
    }
}
