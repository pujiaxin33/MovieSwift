//
//  PeopleRepository.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/27.
//

import Foundation
import Combine

protocol PeopleRepository {
    func fetchPersonDetail(id: Int) -> AnyPublisher<People, Error>
    func fetchPersonImages(id: Int) -> AnyPublisher<ImagesResponse, Error>
    func fetchPersonMovieCredits(id: Int) -> AnyPublisher<PeopleCreditsResponse, Error>
    func searchPeoples(params: [String: Any]) -> AnyPublisher<PaginatedResponse<People>, Error>
}
