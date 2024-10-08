//
//  PeopleDetailViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import Combine
import Networking

@Observable
class PeopleDetailViewModel {
    private(set) var people: People
    private(set) var movieByYears: [MoviesInYear]?
    private(set) var favoritePeoples: [People]
    private let repository: PeopleRepository
    private let storage: FanClubPeopleStorage
    private var imagesResponse: ImagesResponse?
    private var peopleCreditsResponse: PeopleCreditsResponse?
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: PeopleRepository, storage: FanClubPeopleStorage, people: People) {
        self.repository = repository
        self.storage = storage
        self.people = people
        self.favoritePeoples = self.storage.queryAllPeoples()
    }
    
    func loadData() {
        repository.fetchPersonDetail(id: people.id)
            .sink { _ in
                
            } receiveValue: { (data: People) in
                self.people = data
                self.refreshData()
            }.store(in: &bags)

        repository.fetchPersonImages(id: people.id)
            .sink { _ in
                
            } receiveValue: { (data: ImagesResponse) in
                self.imagesResponse = data
                self.refreshData()
            }.store(in: &bags)
        
        repository.fetchPersonMovieCredits(id: people.id)
            .sink { _ in
                
            } receiveValue: { (data: PeopleCreditsResponse) in
                self.peopleCreditsResponse = data
                self.refreshData()
            }.store(in: &bags)
    }
    
    func refreshData() {
        self.people.images = imagesResponse?.profiles
        if let peopleCreditsResponse {
            var years: [String: [Movie]] = [:]
            var workedMovies = peopleCreditsResponse.cast ?? []
            let workedMoviesId = workedMovies.map { $0.id }
            if let crews = peopleCreditsResponse.crew {
                for crew in crews {
                    if !workedMoviesId.contains(crew.id) {
                        workedMovies.append(crew)
                    }
                }
            }
            for movie in workedMovies {
                if movie.release_date != nil && movie.release_date?.isEmpty == false {
                    let year = String(movie.release_date!.prefix(4))
                    if years[year] == nil {
                        years[year] = []
                    }
                    years[year]?.append(movie)
                } else {
                    if years["Upcoming"] == nil {
                        years["Upcoming"] = []
                    }
                    years["Upcoming"]?.append(movie)
                }
            }
            for value in years {
                years[value.key] = value.value.sorted(by: { $0.id > $1.id })
            }
            var allYears: [MoviesInYear] = []
            years.forEach { element in
                allYears.append(.init(year: element.key, movies: element.value.sorted(by: { $0.id > $1.id })))
            }
            allYears.sort { $0.year > $1.year }
            self.movieByYears = allYears
        }
    }
    
    func checkCanShowBiography(people: People) -> Bool {
        return people.biography != nil ||
        people.birthDay != nil ||
        people.place_of_birth != nil ||
        people.deathDay != nil
    }
    
    func favoritePeople(_ people: People) {
        storage.save(people)
        favoritePeoples = storage.queryAllPeoples()
    }
    
    func unfavoritePeople(_ people: People) {
        storage.remove(people)
        favoritePeoples = storage.queryAllPeoples()
    }
    
    func isFavoritePeople(people: People) -> Bool {
        return favoritePeoples.contains(people)
    }
}

struct MoviesInYear: Hashable {
    let year: String
    let movies: [Movie]
}

struct ImagesResponse: Codable {
    let id: Int
    let profiles: [ImageData]
}

struct PeopleCreditsResponse: Codable {
    let cast: [Movie]?
    let crew: [Movie]?
}
