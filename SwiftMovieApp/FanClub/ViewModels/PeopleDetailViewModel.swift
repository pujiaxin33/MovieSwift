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
    var people: People
    var movieByYears: [String: [Movie]]?
    private var imagesResponse: ImagesResponse?
    private var peopleCreditsResponse: PeopleCreditsResponse?
    private var bags: Set<AnyCancellable> = .init()
    
    init(people: People) {
        self.people = people
    }
    
    func loadData() {
        APIService.shared.request(endpoint: .personDetail(person: people.id, params: [:]))
            .sink { _ in
                
            } receiveValue: { (data: People) in
                self.people = data
                self.refreshData()
            }.store(in: &bags)

        APIService.shared.request(endpoint: .personImages(person: people.id, params: [:]))
            .sink { _ in
                
            } receiveValue: { (data: ImagesResponse) in
                self.imagesResponse = data
                self.refreshData()
            }.store(in: &bags)
        
        APIService.shared.request(endpoint: .personMovieCredits(person: people.id, params: [:]))
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
            let workedMovies = (peopleCreditsResponse.cast ?? []) + (peopleCreditsResponse.crew ?? [])
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
            self.movieByYears = years
        }
    }
    
    func checkCanShowBiography(people: People) -> Bool {
        return people.birthDay != nil ||
        people.birthDay != nil ||
        people.place_of_birth != nil ||
        people.deathDay != nil
    }
    
    func isFavoritePeople(people: People, favoritePeoples: [People]) -> Bool {
        return favoritePeoples.contains(people)
    }
}

struct ImagesResponse: Codable {
    let id: Int
    let profiles: [ImageData]
}

struct PeopleCreditsResponse: Codable {
    let cast: [Movie]?
    let crew: [Movie]?
}
