//
//  DefaultPeopleRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking
import Combine

class DefaultPeopleRepository: PeopleRepository {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchPersonDetail(id: Int) -> AnyPublisher<People, Error> {
        return apiService.request(endpoint: .personDetail(person: id))
    }
    
    func fetchPersonImages(id: Int) -> AnyPublisher<ImagesResponse, Error> {
        return apiService.request(endpoint: .personImages(person: id))
    }
    
    func fetchPersonMovieCredits(id: Int) -> AnyPublisher<PeopleCreditsResponse, Error> {
        return apiService.request(endpoint: .personMovieCredits(person: id))
    }
    
}
