//
//  MoviesGenreListViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import SwiftUI
import Networking
import Combine

@Observable
class MoviesGenreListViewModel {
    let genre: Genre
    var movies: [Movie]?
    
    private var bags: Set<AnyCancellable> = .init()
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    func loadData() {
        let params = ["with_genres": "\(genre.id)",
                      "page": "\(1)",
                      "sort_by": MoviesSort.byPopularity.sortByAPI()]
        APIService.shared.request(endpoint: .discover(params: params)).sink { _ in
            
        } receiveValue: { (data: PaginatedResponse<Movie>) in
            self.movies = data.results
        }.store(in: &bags)

    }
}
