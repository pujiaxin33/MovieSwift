//
//  FanClubViewModel.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import Foundation
import Networking
import Combine
import Observation

@Observable
class FanClubViewModel {
    private(set) var peoples: [People]?
    private(set) var favoritePeople: [People] = []
    var isLoading: Bool = false
    var toast: Toast? = nil
    private let repository: FanClubRepository
    private let storage: FanClubPeopleStorage
    private var currentPage: Int = 1
    private var bags: Set<AnyCancellable> = .init()
    
    init(repository: FanClubRepository, storage: FanClubPeopleStorage) {
        self.repository = repository
        self.storage = storage
    }
    
    func loadData() {
        isLoading = true
        let region = Locale.current.region?.identifier ?? "US"
        let params = ["page": "\(currentPage)",
                      "region": region]
        repository.fetchPopularPersons(params: params)
            .delay(for: 2, scheduler: DispatchQueue.main)
            .sink { (completion) in
                self.isLoading = false
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.toast = .init(style: .error, message: error.localizedDescription)
                }
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
