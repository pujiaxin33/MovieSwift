//
//  MockFanClubRepository.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
@testable import SwiftMovieApp
import Combine

class MockFanClubRepository: FanClubRepository {
    var mockResult: Result<PaginatedResponse<People>, Error>!

    func fetchPopularPersons(params: [String : Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return Result.Publisher(mockResult).eraseToAnyPublisher()
    }
}
