import Foundation
import Combine

protocol MovieDetailUseCase {
    func fetchMovieDetail(id: Int, params: [String: Any]) -> AnyPublisher<Movie, Error>
    func fetchMovieCredits(id: Int) -> AnyPublisher<CastResponse, Error>
    func fetchRecommendedMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    func fetchSimilarMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error>
    func fetchMovieReviews(id: Int, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Review>, Error>
    func fetchMovieVideos(id: Int) -> AnyPublisher<PaginatedResponse<Video>, Error>
    func fetchSeenMovies() -> [Movie]
    func fetchWishMovies() -> [Movie]
    func saveToSeenList(movie: Movie)
    func removeFromSeenList(movie: Movie)
    func saveToWishList(movie: Movie)
    func removeFromWishList(movie: Movie)
}

class DefaultMovieDetailUseCase: MovieDetailUseCase {
    private let repository: MoviesRepository
    private let seenMoviesStorage: SeenMoviesStorage
    private let wishMoviesStorage: WishMoviesStorage

    init(repository: MoviesRepository, seenMoviesStorage: SeenMoviesStorage, wishMoviesStorage: WishMoviesStorage) {
        self.repository = repository
        self.seenMoviesStorage = seenMoviesStorage
        self.wishMoviesStorage = wishMoviesStorage
    }

    func fetchMovieDetail(id: Int, params: [String: Any]) -> AnyPublisher<Movie, Error> {
        return repository.fetchMovieDetail(id: id, params: params)
    }

    func fetchMovieCredits(id: Int) -> AnyPublisher<CastResponse, Error> {
        return repository.fetchMovieCredits(id: id)
    }

    func fetchRecommendedMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return repository.fetchRecommendedMovies(id: id)
    }

    func fetchSimilarMovies(id: Int) -> AnyPublisher<PaginatedResponse<Movie>, Error> {
        return repository.fetchSimilarMovies(id: id)
    }

    func fetchMovieReviews(id: Int, params: [String: Any]) -> AnyPublisher<PaginatedResponse<Review>, Error> {
        return repository.fetchMovieReviews(id: id, params: params)
    }

    func fetchMovieVideos(id: Int) -> AnyPublisher<PaginatedResponse<Video>, Error> {
        return repository.fetchMovieVideos(id: id)
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
