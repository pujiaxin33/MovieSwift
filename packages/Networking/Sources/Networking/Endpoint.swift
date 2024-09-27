//
//  File.swift
//  
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Moya
import Combine
import CombineMoya

public enum Endpoint: TargetType {
    case popular(params: [String: Any])
    case topRated(params: [String: Any])
    case upcoming(params: [String: Any])
    case trending(params: [String: Any])
    case nowPlaying(params: [String: Any])
    case genres(params: [String: Any])
    case movieDetail(movie: Int, params: [String: Any])
    case recommended(movie: Int)
    case similar(movie: Int)
    case videos(movie: Int)
    case credits(movie: Int)
    case review(movie: Int, params: [String: Any])
    case searchMovie(params: [String: Any])
    case searchKeyword(params: [String: Any])
    case searchPerson(params: [String: Any])
    case popularPersons(params: [String: Any])
    case personDetail(person: Int)
    case personMovieCredits(person: Int)
    case personImages(person: Int)
    case discover(params: [String: Any])
    
    public var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .trending:
            return "trending/movie/day"
        case .genres:
            return "genre/movie/list"
        case let .movieDetail(movie, _):
            return "movie/\(String(movie))"
        case let .videos(movie):
            return "movie/\(String(movie))/videos"
        case let .personDetail(person):
            return "person/\(String(person))"
        case let .credits(movie):
            return "movie/\(String(movie))/credits"
        case let .review(movie, _):
            return "movie/\(String(movie))/reviews"
        case let .recommended(movie):
            return "movie/\(String(movie))/recommendations"
        case let .similar(movie):
            return "movie/\(String(movie))/similar"
        case let .personMovieCredits(person):
            return "person/\(person)/movie_credits"
        case let .personImages(person):
            return "person/\(person)/images"
        case .searchMovie:
            return "search/movie"
        case .searchKeyword:
            return "search/keyword"
        case .searchPerson:
            return "search/person"
        case .discover:
            return "discover/movie"
        case .popularPersons:
            return "person/popular"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .popular(params: let params),
                .topRated(params: let params),
                .upcoming(params: let params),
                .trending(params: let params),
                .nowPlaying(params: let params),
                .genres(params: let params),
                .searchMovie(params: let params),
                .searchKeyword(params: let params),
                .searchPerson(params: let params),
                .discover(params: let params):
            return .requestParameters(parameters: mergeParameters(params), encoding: URLEncoding())
        case .movieDetail(_, let params),
                .review(_, let params),
                .popularPersons(params: let params):
            return .requestParameters(parameters: mergeParameters(params), encoding: URLEncoding())
        case .videos,
                .personDetail,
                .credits,
                .recommended,
                .similar,
                .personMovieCredits,
                .personImages:
            return .requestParameters(parameters: mergeParameters([:]), encoding: URLEncoding())
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    private func mergeParameters(_ params: [String: Any]) -> [String: Any] {
        var result: [String: Any] = ["api_key": DefaultAPIService.apiKey, "language": Locale.preferredLanguages[0]]
        return result.reduce(into: params) { (partialResult, element) in
            partialResult[element.key] = element.value
        }
    }
}
