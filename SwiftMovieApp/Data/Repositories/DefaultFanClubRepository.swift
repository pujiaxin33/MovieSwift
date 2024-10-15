//
//  DefaultFanClubRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Networking
import Combine

class DefaultFanClubRepository: FanClubRepository {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchPopularPersons(params: [String : Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return apiClient.request(endpoint: .popularPersons(params: params))
    }
}
