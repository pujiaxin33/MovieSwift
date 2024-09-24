import Foundation

public class ImageService {
    
    public enum Size: String {
        case small = "https://image.tmdb.org/t/p/w154/"
        case medium = "https://image.tmdb.org/t/p/w500/"
        case cast = "https://image.tmdb.org/t/p/w185/"
        case original = "https://image.tmdb.org/t/p/original/"
    }
    
    public static func posterUrl(path: String, size: Size) -> URL {
        return URL(string: size.rawValue)!.appendingPathComponent(path)
    }

}
