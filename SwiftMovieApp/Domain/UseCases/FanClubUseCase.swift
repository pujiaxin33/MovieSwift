//
//  FanClubUseCase.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
import Combine

protocol FanClubUseCase {
    func fetchPopularPersons(params: [String: Any]) -> AnyPublisher<PaginatedResponse<People>, Error>
    func remove(_ people: People)
    func queryAllPeoples() -> [People] 
}

class DefaultFanClubUseCase: FanClubUseCase {
    let repository: FanClubRepository
    let storage: FanClubPeopleStorage
    
    init(repository: FanClubRepository, storage: FanClubPeopleStorage) {
        self.repository = repository
        self.storage = storage
    }
    
    func fetchPopularPersons(params: [String: Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return repository.fetchPopularPersons(params: params)
    }
    
    func remove(_ people: People) {
        storage.remove(people)
    }
    
    func queryAllPeoples() -> [People] {
        return storage.queryAllPeoples()
    }
    
}
