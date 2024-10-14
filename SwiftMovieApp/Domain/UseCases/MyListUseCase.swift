import Foundation
import Combine

protocol MyListUseCase {
    func fetchSeenMovies() -> [Movie]
    func fetchWishMovies() -> [Movie]
    func saveToSeenList(movie: Movie)
    func removeFromSeenList(movie: Movie)
    func saveToWishList(movie: Movie)
    func removeFromWishList(movie: Movie)
}

class DefaultMyListUseCase: MyListUseCase {
    private let seenMoviesStorage: SeenMoviesStorage
    private let wishMoviesStorage: WishMoviesStorage

    init(seenMoviesStorage: SeenMoviesStorage, wishMoviesStorage: WishMoviesStorage) {
        self.seenMoviesStorage = seenMoviesStorage
        self.wishMoviesStorage = wishMoviesStorage
    }

    func fetchSeenMovies() -> [Movie] {
        return seenMoviesStorage.queryAllItems()
    }

    func fetchWishMovies() -> [Movie] {
        return wishMoviesStorage.queryAllItems()
    }

    func saveToSeenList(movie: Movie) {
        seenMoviesStorage.save(movie)
    }

    func removeFromSeenList(movie: Movie) {
        seenMoviesStorage.remove(movie)
    }

    func saveToWishList(movie: Movie) {
        wishMoviesStorage.save(movie)
    }

    func removeFromWishList(movie: Movie) {
        wishMoviesStorage.remove(movie)
    }
}