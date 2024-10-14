//
//  WishMoviesStorage.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/14.
//

import Foundation
import SQLite

protocol WishMoviesStorage {
    func createTable()
    func save(_ movie: Movie)
    func remove(_ movie: Movie)
    func queryAllItems() -> [Movie]
    func deleteAllItems()
}

class DefaultWishMoviesStorage: WishMoviesStorage {
    var db: Connection?
    let moviesTable = Table("movies")

    let id = Expression<Int>("id")
    let originalTitle = Expression<String>("original_title")
    let title = Expression<String>("title")
    let overview = Expression<String>("overview")
    let posterPath = Expression<String?>("poster_path")
    let backdropPath = Expression<String?>("backdrop_path")
    let popularity = Expression<Double>("popularity")
    let voteAverage = Expression<Double>("vote_average")
    let voteCount = Expression<Int>("vote_count")
    let releaseDate = Expression<String?>("release_date")
    let runtime = Expression<Int?>("runtime")
    let status = Expression<String?>("status")
    let video = Expression<Bool>("video")
    let character = Expression<String?>("character")
    let department = Expression<String?>("department")
    let productionCountries = Expression<String?>("production_countries") // Store as JSON
    let genres = Expression<String?>("genres") // Store as JSON
    let keywords = Expression<String?>("keywords") // Store as JSON
    let images = Expression<String?>("images") // Store as JSON
    
    init() {
        var documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentUrl.append(component: "WishMovies.sqlite3")
        db = try? Connection(documentUrl.path())
    }
    
    func createTable() {
        do {
            try db?.run(moviesTable.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(originalTitle)
                table.column(title)
                table.column(overview)
                table.column(posterPath)
                table.column(backdropPath)
                table.column(popularity)
                table.column(voteAverage)
                table.column(voteCount)
                table.column(releaseDate)
                table.column(runtime)
                table.column(status)
                table.column(video)
                table.column(character)
                table.column(department)
                table.column(productionCountries)
                table.column(genres)
                table.column(keywords)
                table.column(images)
            })
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func save(_ movie: Movie) {
        remove(movie)
        do {
            let genresJson = try encodeToJson(movie.genres)
            let countriesJson = try encodeToJson(movie.production_countries)
            let keywordsJson = try encodeToJson(movie.keywords)
            let imagesJson = try encodeToJson(movie.images)

            let insert = moviesTable.insert(
                id <- movie.id,
                originalTitle <- movie.original_title,
                title <- movie.title,
                overview <- movie.overview,
                posterPath <- movie.poster_path,
                backdropPath <- movie.backdrop_path,
                popularity <- Double(movie.popularity),
                voteAverage <- Double(movie.vote_average),
                voteCount <- movie.vote_count,
                releaseDate <- movie.release_date,
                runtime <- movie.runtime,
                status <- movie.status,
                video <- movie.video,
                character <- movie.character,
                department <- movie.department,
                productionCountries <- countriesJson,
                genres <- genresJson,
                keywords <- keywordsJson,
                images <- imagesJson
            )
            try db?.run(insert)
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func remove(_ movie: Movie) {
        do {
            let toDelete = moviesTable.filter(id == movie.id)
            try db?.run(toDelete.delete())
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func queryAllItems() -> [Movie] {
        do {
            var rows: [Row] = []
            if let data = try db?.prepare(moviesTable) {
                rows = Array(data)
            }
            var movies: [Movie] = []
            for movie in rows {
                let fetchedGenres = try decodeFromJson([Genre].self, jsonString: movie[genres])
                let fetchedCountries = try decodeFromJson([Movie.productionCountry].self, jsonString: movie[productionCountries])
                let fetchedKeywords = try decodeFromJson(Movie.Keywords.self, jsonString: movie[keywords])
                let fetchedImages = try decodeFromJson(Movie.MovieImages.self, jsonString: movie[images])
                
                let fetchedMovie = Movie(
                    id: movie[id],
                    original_title: movie[originalTitle],
                    title: movie[title],
                    overview: movie[overview],
                    poster_path: movie[posterPath],
                    backdrop_path: movie[backdropPath],
                    popularity: Float(movie[popularity]),
                    vote_average: Float(movie[voteAverage]),
                    vote_count: movie[voteCount],
                    release_date: movie[releaseDate],
                    genres: fetchedGenres,
                    runtime: movie[runtime],
                    status: movie[status],
                    video: movie[video],
                    keywords: fetchedKeywords,
                    images: fetchedImages,
                    production_countries: fetchedCountries,
                    character: movie[character],
                    department: movie[department]
                )
                movies.append(fetchedMovie)
            }
            return movies
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
            return []
        }
    }
    
    func deleteAllItems() {
        do {
            try db?.run(moviesTable.delete())
        } catch (let error) {
            print("\(String(describing: self)) call \(#function) with error:\(error.localizedDescription)")
        }
    }
    
    func encodeToJson<T: Encodable>(_ data: T?) throws -> String? {
        guard let data = data else { return nil }
        let jsonData = try JSONEncoder().encode(data)
        return String(data: jsonData, encoding: .utf8)
    }
    
    func decodeFromJson<T: Decodable>(_ type: T.Type, jsonString: String?) throws -> T? {
        guard let jsonString = jsonString else { return nil }
        let jsonData = jsonString.data(using: .utf8)!
        return try JSONDecoder().decode(type, from: jsonData)
    }
}
