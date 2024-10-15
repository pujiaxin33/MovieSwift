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
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPersonDetail(id: Int) -> AnyPublisher<People, Error> {
        return apiClient.request(endpoint: .personDetail(person: id))
    }
    
    func fetchPersonImages(id: Int) -> AnyPublisher<ImagesResponse, Error> {
        return apiClient.request(endpoint: .personImages(person: id))
    }
    
    func fetchPersonMovieCredits(id: Int) -> AnyPublisher<PeopleCreditsResponse, Error> {
        return apiClient.request(endpoint: .personMovieCredits(person: id))
    }
    
    func searchPeoples(params: [String : Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return apiClient.request(endpoint: .searchPerson(params: params))
    }
}
