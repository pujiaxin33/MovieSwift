//
//  DiscoverViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/10.
//

import Foundation
import Observation
import Combine

@Observable
class DiscoverViewModel {
    let repository: MoviesHomeRepository
    private(set) var movies: [Movie] = []
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: MoviesHomeRepository) {
        self.repository = repository
    }
    
    func loadData() {
        repository.fetchDiscoverMovies(params: randomParams())
            .sink { _ in
            } receiveValue: { data in
                self.movies = data.results
            }.store(in: &bags)
    }
    
    func randomParams() -> [String: String] {
        var params: [String: String] = [:]
        params["year"] = "\(randomYear())"
        params["with_genres"] = "\(randomGenre())"
        params["page"] = "\(randomPage())"
        params["sort_by"] = randomSort()
        params["language"] = "en-US"
        return params
    }
    func randomGenre() -> Int {
        let genreIdArray = [28, 12, 16, 35, 80, 99, 18, 10751,14, 36, 27, 10402, 9648, 10749, 878, 10770, 53, 10752, 37]
        return genreIdArray.randomElement() ?? 28
    }
    
    func randomPage() -> Int {
        return Int.random(in: 1..<20)
    }
    
    func randomYear() -> Int {
        let calendar = Calendar.current
        return Int.random(in: 1950..<calendar.component(.year, from: Date()))
    }
    
    func randomSort() -> String {
        let sortBy = ["popularity.desc",
                      "popularity.asc",
                      "vote_average.asc",
                      "vote_average.desc"]
        return sortBy[Int.random(in: 0..<sortBy.count)]
    }
}
