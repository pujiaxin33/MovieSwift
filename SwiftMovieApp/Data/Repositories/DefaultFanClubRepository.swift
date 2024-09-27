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
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func fetchPopularPersons(params: [String : Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return apiService.request(endpoint: .popularPersons(params: params))
    }
}
