//
//  MockAPIService.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/10/8.
//

import Foundation
import Networking
import Combine

public struct MockAPIService: APIService {
    enum Result {
        case success(Data)
        case failure(Error)
    }
    
    enum MockError: Error {
        case test
    }
    
    let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    public func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        switch result {
        case .success(let data):
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
