//
//  DefaultMoviesHomeRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking
import Combine

class DefaultMoviesRepository: MoviesRepository {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchMovies(menu: MoviesMenu, params: [String : Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiClient.request(endpoint: menu.endpoint(params: params))
    }
    
    func fetchGenres(params: [String : Any]) -> AnyPublisher<GenresResponse, Error> {
        return apiClient.request(endpoint: MoviesMenu.genres.endpoint(params: params))
    }
    
    func fetchMovieDetail(id: Int, params: [String: Any]) -> AnyPublisher<Movie, Error> {
        return apiClient.request(endpoint: .movieDetail(movie: id, params: params))
    }
    
    func fetchMovieCredits(id: Int) -> AnyPublisher<CastResponse, Error> {
        return apiClient.request(endpoint: .credits(movie: id))
    }
    
    func fetchRecommendedMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiClient.request(endpoint: .recommended(movie: id))
    }
    
    func fetchSimilarMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiClient.request(endpoint: .similar(movie: id))
    }
    
    func fetchMovieReviews(id: Int, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Review>, Error> {
        return apiClient.request(endpoint: .review(movie: id, params: params))
    }
    
    func fetchMovieVideos(id: Int) -> AnyPublisher<PaginatedResponse<Video>, Error> {
        return apiClient.request(endpoint: .videos(movie: id))
    }
    
    func fetchDiscoverMovies(params: [String : Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiClient.request(endpoint: .discover(params: params))
    }
    
    func searchMovies(params: [String : Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return apiClient.request(endpoint: .searchMovie(params: params))
    }
    
    func searchKeywords(params: [String : Any]) -> AnyPublisher<PaginatedResponse<Keyword>, Error> {
        return apiClient.request(endpoint: .searchKeyword(params: params))
    }
}
