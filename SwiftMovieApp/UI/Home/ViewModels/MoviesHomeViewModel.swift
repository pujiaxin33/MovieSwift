//
//  MoviesHomeViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import Foundation
import Networking
import Combine
import Observation

@Observable
class MoviesHomeViewModel {
    let repository: MoviesRepository
    var movies: [MoviesMenu : [Movie]] = [:]
    var genres: [Genre] = []
    
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func loadData() {
        let region = Locale.current.region?.identifier ?? "US"
        MoviesMenu.allCases.forEach { menu in
            if menu == .genres {
                repository.fetchGenres(params: ["page": "1", "region": region]).sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: {[weak self] (data: GenresResponse) in
                    self?.genres = data.genres
                }.store(in: &bags)
            } else {
                repository.fetchMovies(menu: menu, params: ["page": "1", "region": region]).sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: {[weak self] (data: PaginatedResponse<Movie>) in
                    self?.movies[menu] = data.results
                }.store(in: &bags)
            }
        }
    }
    
}
