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
    let repository: MoviesHomeRepository
    let seenMoviesStorage: SeenMoviesStorage
    let wishMoviesStorage: WishMoviesStorage
    var movie: Movie
    var cast: CastResponse?
    var recommendedMovies: [Movie]?
    var similarMovies: [Movie]?
    var reviews: [Review]?
    var videos: [Video]?
    var isInWishlist: Bool = false
    var isInSeenlist: Bool = false
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: MoviesHomeRepository, seenMoviesStorage: SeenMoviesStorage, wishMoviesStorage: WishMoviesStorage, movie: Movie) {
        self.repository = repository
        self.seenMoviesStorage = seenMoviesStorage
        self.wishMoviesStorage = wishMoviesStorage
        self.movie = movie
        
        isInWishlist = wishMoviesStorage.queryAllItems().contains(movie)
        isInSeenlist = seenMoviesStorage.queryAllItems().contains(movie)
    }
    
    func loadData() {
        let params = ["append_to_response": "keywords,images",
                      "include_image_language": "\(Locale.current.language.languageCode?.identifier ?? "en"),en,null"]
        repository.fetchMovieDetail(id: movie.id, params: params).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { (data: Movie) in
            self.movie = data
        }.store(in: &bags)
        
        repository.fetchMovieCredits(id: movie.id)
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

        repository.fetchRecommendedMovies(id:  movie.id)
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
        
        repository.fetchSimilarMovies(id:  movie.id)
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
        
        repository.fetchMovieReviews(id:  movie.id, params: ["language": Locale.current.language.languageCode?.identifier ?? "zh-CN"])
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
        
        repository.fetchMovieVideos(id: movie.id)
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
        seenMoviesStorage.save(movie)
    }
    
    func removeFromSeenList() {
        isInSeenlist = false
        seenMoviesStorage.remove(movie)
    }
    
    func addToWishList() {
        isInWishlist = true
        wishMoviesStorage.save(movie)
    }
    
    func removeFromWishList() {
        isInWishlist = false
        wishMoviesStorage.remove(movie)
    }
}
