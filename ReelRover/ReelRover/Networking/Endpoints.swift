import Foundation

final class Endpoints {
    
    private static let baseURL = "https://api.themoviedb.org/3"
    
    static var searchMovie: URL {
        return URL(string: "\(baseURL)/search/movie")!
    }
    
    /// For the sake of simplicity, I hardcoded this account id.
    static var favoriteMovies: URL {
        return URL(string: "\(baseURL)/account/20953418/favorite/movies")!
    }
    
    /// For the sake of simplicity, I hardcoded this account id.
    static var favorite: URL {
        return URL(string: "\(baseURL)/account/20953418/favorite")!
    }
}
