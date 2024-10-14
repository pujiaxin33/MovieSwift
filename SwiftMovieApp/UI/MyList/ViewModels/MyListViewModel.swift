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
    let seenMoviesStorage: SeenMoviesStorage
    let wishMoviesStorage: WishMoviesStorage
    var showMovies: [Movie] = []
    private var seenMovies: [Movie] = []
    private var wishMovies: [Movie] = []
    var listType: MoviesListType = .wish {
        didSet {
            refreshShowMovies()
        }
    }
    
    init(seenMoviesStorage: SeenMoviesStorage, wishMoviesStorage: WishMoviesStorage) {
        self.seenMoviesStorage = seenMoviesStorage
        self.wishMoviesStorage = wishMoviesStorage
    }
    
    func loadData() {
        seenMovies = seenMoviesStorage.queryAllItems()
        wishMovies = wishMoviesStorage.queryAllItems()
        refreshShowMovies()
    }
    
    func refreshShowMovies() {
        switch listType {
        case .wish:
            showMovies = wishMovies
        case .seen:
            showMovies = seenMovies
        }
    }
}
