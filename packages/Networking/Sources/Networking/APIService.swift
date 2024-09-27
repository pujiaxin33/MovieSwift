import Foundation
import Moya
import Combine
import CombineMoya

public protocol APIService {
    func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

public struct DefaultAPIService: APIService {
    public static let shared = DefaultAPIService()
    
    let baseURL = URL(string: "https://api.themoviedb.org/3")!
    static let apiKey = "1d9b898a212ea52e283351e521e17871"
    private let moyaProvider = MoyaProvider<Endpoint>()
    private let decoder = JSONDecoder()
    
    public enum APIError: Error {
        case networkError(error: Error)
    }
    
    public func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        return moyaProvider.requestPublisher(endpoint)
            .map(T.self, using: self.decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

