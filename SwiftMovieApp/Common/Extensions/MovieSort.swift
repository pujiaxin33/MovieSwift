//
//  MovieSort.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation

enum MoviesSort {
    case byReleaseDate, byAddedDate, byScore, byPopularity
    
    func title() -> String {
        switch self {
        case .byReleaseDate:
            return "by release date"
        case .byAddedDate:
            return "by added date"
        case .byScore:
            return "by rating"
        case .byPopularity:
            return "by popularity"
        }
    }
    
    func sortByAPI() -> String {
        switch self {
        case .byReleaseDate:
            return "release_date.desc"
        case .byAddedDate:
            return "primary_release_date.desc"
        case .byScore:
            return "vote_average.desc"
        case .byPopularity:
            return "popularity.desc"
        }
    }
}
