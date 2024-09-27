//
//  DefaultMoviesHomeRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking
import Combine

class DefaultMoviesHomeRepository: MoviesHomeRepository {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchMovies(menu: MoviesMenu, params: [String : Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiService.request(endpoint: menu.endpoint(params: params))
    }
    
    func fetchGenres(params: [String : Any]) -> AnyPublisher<GenresResponse, Error> {
        return apiService.request(endpoint: MoviesMenu.genres.endpoint(params: params))
    }
    
    func fetchMovieDetail(id: Int, params: [String: Any]) -> AnyPublisher<Movie, Error> {
        return apiService.request(endpoint: .movieDetail(movie: id, params: params))
    }
    
    func fetchMovieCredits(id: Int) -> AnyPublisher<CastResponse, Error> {
        return apiService.request(endpoint: .credits(movie: id))
    }
    
    func fetchRecommendedMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiService.request(endpoint: .recommended(movie: id))
    }
    
    func fetchSimilarMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiService.request(endpoint: .similar(movie: id))
    }
    
    func fetchMovieReviews(id: Int, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Review>, Error> {
        return apiService.request(endpoint: .review(movie: id, params: params))
    }
    
    func fetchMovieVideos(id: Int) -> AnyPublisher<PaginatedResponse<Video>, Error> {
        return apiService.request(endpoint: .videos(movie: id))
    }
    
    func fetchDiscoverMovies(params: [String : Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiService.request(endpoint: .discover(params: params))
    }
}
