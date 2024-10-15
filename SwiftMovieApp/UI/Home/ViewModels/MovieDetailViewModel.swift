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
    private let useCase: MovieDetailUseCase
    var movie: Movie
    var cast: CastResponse?
    var recommendedMovies: [Movie]?
    var similarMovies: [Movie]?
    var reviews: [Review]?
    var videos: [Video]?
    var isInWishlist: Bool = false
    var isInSeenlist: Bool = false
    private var bags: Set<AnyCancellable> = .init()

    init(useCase: MovieDetailUseCase, movie: Movie) {
        self.useCase = useCase
        self.movie = movie
        
        isInWishlist = useCase.fetchWishMovies().map { $0.id }.contains(movie.id)
        isInSeenlist = useCase.fetchSeenMovies().map { $0.id }.contains(movie.id)
    }

    func loadData() {
        let params = ["append_to_response": "keywords,images",
                      "include_image_language": "\(Locale.current.language.languageCode?.identifier ?? "en"),en,null"]
        
        useCase.fetchMovieDetail(id: movie.id, params: params)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: Movie) in
                self.movie = data
            }.store(in: &bags)

        useCase.fetchMovieCredits(id: movie.id)
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

        useCase.fetchRecommendedMovies(id: movie.id)
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

        useCase.fetchSimilarMovies(id: movie.id)
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

        useCase.fetchMovieReviews(id: movie.id, params: ["language": Locale.current.language.languageCode?.identifier ?? "zh-CN"])
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { (data: PaginatedResponse<Review>) in
                self.reviews = data.results
            }.store(in: &bags)

        useCase.fetchMovieVideos(id: movie.id)
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

    func addToSeenList() {
        isInSeenlist = true
        useCase.saveToSeenList(movie: movie)
    }

    func removeFromSeenList() {
        isInSeenlist = false
        useCase.removeFromSeenList(movie: movie)
    }

    func addToWishList() {
        isInWishlist = true
        useCase.saveToWishList(movie: movie)
    }

    func removeFromWishList() {
        isInWishlist = false
        useCase.removeFromWishList(movie: movie)
    }
}
