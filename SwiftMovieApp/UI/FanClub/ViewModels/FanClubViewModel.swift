//
//  FanClubViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import Networking
import Combine

@Observable
class FanClubViewModel {
    private(set) var peoples: [People]?
    private(set) var favoritePeople: [People] = []
    private let repository: FanClubRepository
    private let storage: FanClubPeopleStorage
    private var currentPage: Int = 1
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: FanClubRepository, storage: FanClubPeopleStorage) {
        self.repository = repository
        self.storage = storage
    }
    
    func loadData() {
        let region = Locale.current.region?.identifier ?? "US"
        let params = ["page": "\(currentPage)",
                      "region": region]
        repository.fetchPopularPersons(params: params)
            .sink { _ in
                
            } receiveValue: { (data: PaginatedResponse<People>) in
                self.peoples = data.results
            }.store(in: &bags)
    }
    
    func refreshFavoritePeople() {
        favoritePeople = storage.queryAllPeoples()
    }
    
    func removePeople(people: People) {
        storage.remove(people)
    }
}
