//
//  MoviesMenu.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import Foundation
import Networking

enum MoviesMenu: Int, CaseIterable {
    case nowPlaying, upcoming, trending, popular, topRated, genres
    
    func title() -> String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .nowPlaying: return "Now Playing"
        case .trending: return "Trending"
        case .genres: return "Genres"
        }
    }
    
    func endpoint(params: [String: Any]) -> APIService.Endpoint {
        switch self {
        case .popular: return APIService.Endpoint.popular(params: params)
        case .topRated: return APIService.Endpoint.topRated(params: params)
        case .upcoming: return APIService.Endpoint.upcoming(params: params)
        case .nowPlaying: return APIService.Endpoint.nowPlaying(params: params)
        case .trending: return APIService.Endpoint.trending(params: params)
        case .genres: return APIService.Endpoint.genres(params: params)
        }
    }
}
