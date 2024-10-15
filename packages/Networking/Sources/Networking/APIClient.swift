import Foundation
import Moya
import Combine
import CombineMoya

public protocol APIClient {
    func request<T: Codable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

public struct DefaultAPIClient: APIClient {
    public static let shared = DefaultAPIClient()
    
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

