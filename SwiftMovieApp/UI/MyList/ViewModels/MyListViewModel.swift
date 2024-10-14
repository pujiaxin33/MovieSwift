//
//  MyListViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/14.
//

import Foundation
import Observation

enum MoviesListType: Int {
    case wish
    case seen
    
    var nameInSectionHeader: String {
        switch self {
        case .wish:
            return "WISHLIST"
        case .seen:
            return "SEENLIST"
        }
    }
}

@Observable
class MyListViewModel {
    private let useCase: MyListUseCase
    var showMovies: [Movie] = []
    var listType: MoviesListType = .wish {
        didSet {
            refreshShowMovies()
        }
    }

    init(useCase: MyListUseCase) {
        self.useCase = useCase
        loadData()
    }

    func loadData() {
        refreshShowMovies()
    }

    func refreshShowMovies() {
        switch listType {
        case .wish:
            showMovies = useCase.fetchWishMovies()
        case .seen:
            showMovies = useCase.fetchSeenMovies()
        }
    }

    func addToSeenList(movie: Movie) {
        useCase.saveToSeenList(movie: movie)
        refreshShowMovies()
    }

    func removeFromSeenList(movie: Movie) {
        useCase.removeFromSeenList(movie: movie)
        refreshShowMovies()
    }

    func addToWishList(movie: Movie) {
        useCase.saveToWishList(movie: movie)
        refreshShowMovies()
    }

    func removeFromWishList(movie: Movie) {
        useCase.removeFromWishList(movie: movie)
        refreshShowMovies()
    }
}
