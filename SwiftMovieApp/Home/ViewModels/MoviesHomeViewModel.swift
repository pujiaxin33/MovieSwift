//
//  MoviesHomeViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import Foundation
import Networking
import Combine

@Observable
class MoviesHomeViewModel {
    var movies: [MoviesMenu : [Movie]] = [:]
    
    private var bags: Set<AnyCancellable> = .init()
    
    init() {
        loadData()
    }
    
    func loadData() {
//        movies[.popular] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
//        movies[.topRated] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
//        movies[.upcoming] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
//        movies[.nowPlaying] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
//        movies[.trending] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
        
        let region = Locale.current.region?.identifier ?? "US"
        APIService.shared.request(endpoint: .nowPlaying(params: ["page": "1", "region": region])).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (data: PaginatedResponse<Movie>) in
            self.movies[.nowPlaying] = data.results
        }.store(in: &bags)

    }
    
}
