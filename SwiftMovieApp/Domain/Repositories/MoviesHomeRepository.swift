//
//  MoviesHomeRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Combine

protocol MoviesHomeRepository {
    func fetchMovies(menu: MoviesMenu, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    func fetchGenres(params: [String: Any]) -> AnyPublisher<GenresResponse, Error>
    func fetchMovieDetail(id: Int, params: [String: Any]) -> AnyPublisher<Movie, Error>
    func fetchMovieCredits(id: Int) -> AnyPublisher<CastResponse, Error>
    func fetchRecommendedMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    func fetchSimilarMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    func fetchMovieReviews(id: Int, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Review>, Error>
    func fetchMovieVideos(id: Int) -> AnyPublisher<PaginatedResponse<Video>, Error>
    func fetchDiscoverMovies(params: [String: Any]) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    
}
