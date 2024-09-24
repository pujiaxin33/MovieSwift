//
//  MoviesHomeViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/23.
//

import Foundation

@Observable
class MoviesHomeViewModel {
    var movies: [MoviesMenu : [Movie]] = [:]
    
    init() {
        loadData()
    }
    
    func loadData() {
        movies[.popular] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
        movies[.topRated] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
        movies[.upcoming] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
        movies[.nowPlaying] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
        movies[.trending] = [sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, sampleMovie, ]
    }
    
}
