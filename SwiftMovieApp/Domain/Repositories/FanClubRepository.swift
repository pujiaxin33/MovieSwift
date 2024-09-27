//
//  FanClubRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Combine

protocol FanClubRepository {
    func fetchPopularPersons(params: [String: Any]) -> AnyPublisher<PaginatedResponse<People>, Error>
}
