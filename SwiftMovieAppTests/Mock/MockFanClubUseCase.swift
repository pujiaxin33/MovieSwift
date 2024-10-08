//
//  MockFanClubUseCase.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
@testable import SwiftMovieApp
import Combine

class MockFanClubUseCase: FanClubUseCase {
    var mockResult: Result<PaginatedResponse<People>, Error>!

    func fetchPopularPersons(params: [String : Any]) -> AnyPublisher<PaginatedResponse<People>, Error> {
        return Result.Publisher(mockResult).eraseToAnyPublisher()
    }

    func remove(_ people: People) {
        // Mock implementation
    }

    func queryAllPeoples() -> [People] {
        return [] // Mock implementation
    }
}
