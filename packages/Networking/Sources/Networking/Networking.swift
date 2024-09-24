import Foundation
import Moya
import Combine
import CombineMoya

public struct APIService {
    let baseURL = URL(string: "https://api.themoviedb.org/3")!
    static let apiKey = "1d9b898a212ea52e283351e521e17871"
    public static let shared = APIService()
    let moyaProvider = MoyaProvider<APIService.Endpoint>()
    let decoder = JSONDecoder()
    
    public enum APIError: Error {
        case networkError(error: Error)
    }
    
    public enum Endpoint: TargetType {
        case popular(params: [String: Any])
        case topRated(params: [String: Any])
        case upcoming(params: [String: Any])
        case trending(params: [String: Any])
        case nowPlaying(params: [String: Any])
        case genres(params: [String: Any])
        

        public var baseURL: URL {
            URL(string: "https://api.themoviedb.org/3")!
        }
        public var path: String {
            switch self {
            case .popular:
                return "movie/popular"
            case .topRated:
                return "movie/top_rated"
            case .upcoming:
                return "movie/upcoming"
            case .nowPlaying:
                return "movie/now_playing"
            case .trending:
                return "trending/movie/day"
            case .genres:
                return "genre/movie/list"
            }
        }
        public var method: Moya.Method {
            return .get
        }
        public var task: Task {
            switch self {
            case .popular(params: let params),
                    .topRated(params: let params),
                    .upcoming(params: let params),
                    .trending(params: let params),
                    .nowPlaying(params: let params),
                    .genres(params: let params):
                return .requestParameters(parameters: mergeParameters(params), encoding: URLEncoding())
            }
        }
        
        public var headers: [String: String]? {
            return nil
        }
        
        private func mergeParameters(_ params: [String: Any]) -> [String: Any] {
            var result: [String: Any] = ["api_key": APIService.apiKey, "language": Locale.preferredLanguages[0]]
            return result.reduce(into: params) { (partialResult, element) in
                partialResult[element.key] = element.value
            }
        }
    }
    
    public func request<T: Codable>(endpoint: APIService.Endpoint) -> AnyPublisher<T, Error> {
        return moyaProvider.requestPublisher(endpoint)
            .map(T.self, using: self.decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

