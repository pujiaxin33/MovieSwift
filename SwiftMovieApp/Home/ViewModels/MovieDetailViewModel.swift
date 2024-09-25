//
//  MovieDetailViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import Foundation
import Networking
import Combine

@Observable
class MovieDetailViewModel {
    var movie: Movie
    var cast: CastResponse?
    var recommendedMovies: [Movie]?
    var similarMovies: [Movie]?
    var reviews: [Review]?
    var videos: [Video]?
    private var bags: Set<AnyCancellable> = .init()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func loadData() {
        let params = ["append_to_response": "keywords,images",
                      "include_image_language": "\(Locale.current.language.languageCode?.identifier ?? "en"),en,null"]
        APIService.shared.request(endpoint: .movieDetail(movie: movie.id, params: params)).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (data: Movie) in
            self.movie = data
        }.store(in: &bags)
        
        APIService.shared.request(endpoint: .credits(movie: movie.id, params: [:]))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: CastResponse) in
                self.cast = data
            }.store(in: &bags)

        APIService.shared.request(endpoint: .recommended(movie: movie.id, params: [:]))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: PaginatedResponse<Movie>) in
                self.recommendedMovies = data.results
            }.store(in: &bags)
        
        APIService.shared.request(endpoint: .similar(movie: movie.id, params: [:]))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: PaginatedResponse<Movie>) in
                self.similarMovies = data.results
            }.store(in: &bags)
        
        APIService.shared.request(endpoint: .review(movie: movie.id, params: ["language": Locale.current.language.languageCode?.identifier ?? "zh-CN"]))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: PaginatedResponse<Review>) in
                self.reviews = sampleReviews
            }.store(in: &bags)
        
        APIService.shared.request(endpoint: .videos(movie: movie.id, params: [:]))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: PaginatedResponse<Video>) in
                self.videos = data.results
            }.store(in: &bags)
    }
}
