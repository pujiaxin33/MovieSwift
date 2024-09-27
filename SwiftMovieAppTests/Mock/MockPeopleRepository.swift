//
//  MockPeopleRepository.swift
//  SwiftMovieAppTests
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
@testable import SwiftMovieApp
import Combine

class MockPeopleRepository: PeopleRepository {
    var mockPersonDetailResult: Result<People, Error>!
    var mockPersonImagesResult: Result<ImagesResponse, Error>!
    var mockPersonMovieCreditsResult: Result<PeopleCreditsResponse, Error>!

    func fetchPersonDetail(id: Int) -> AnyPublisher<People, Error> {
        return Result.Publisher(mockPersonDetailResult).eraseToAnyPublisher()
    }

    func fetchPersonImages(id: Int) -> AnyPublisher<ImagesResponse, Error> {
        return Result.Publisher(mockPersonImagesResult).eraseToAnyPublisher()
    }

    func fetchPersonMovieCredits(id: Int) -> AnyPublisher<PeopleCreditsResponse, Error> {
        return Result.Publisher(mockPersonMovieCreditsResult).eraseToAnyPublisher()
    }
}
