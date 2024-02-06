import Alamofire

protocol TMBDGatewayProtocol {
    func updateMovieFavoriteStatus(
        for mediaId: Int,
        addToFavorites: Bool
    ) async throws
    func favoriteMovies() async throws -> [Movie]
    func searchForMovie(named title: String) async throws -> [Movie]
    func headers() -> HTTPHeaders
}

final class TMBDGateway: TMBDGatewayProtocol {
    
    static let shared = TMBDGateway()
    
    /// Adds or removes a movie to your favorites list.
    ///
    /// - Parameter mediaId: The associated id attached to the movie.
    /// - Parameter addToFavorites: Whether we are adding or removing from favorites.
    func updateMovieFavoriteStatus(
        for mediaId: Int,
        addToFavorites: Bool
    ) async throws {
        let parameters: Parameters = [
            "media_type": "movie",
            "media_id": mediaId,
            "favorite": addToFavorites
        ]
        
        let error = await AF.request(
            Endpoints.favorite,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers()
        )
        .validate()
        .serializingData()
        .response
        .error
        
        if let error { throw error }
    }
    
    /// Retrieves the movies you have favorited.
    /// https://developer.themoviedb.org/reference/account-get-favorites
    ///
    /// - Returns: Returns a list of movies that are favorited by you.
    func favoriteMovies() async throws -> [Movie] {
        return try await AF.request(
            Endpoints.favoriteMovies,
            method: .get,
            headers: headers()
        )
        .serializingDecodable(MoviesResponse.self)
        .value
        .results
    }
    
    
    /// "Search for movies by their original, translated and alternative titles." - API Description
    /// https://developer.themoviedb.org/reference/search-movie
    ///
    /// - Parameter title: The title of the movie being searched for.
    /// - Returns: Returns a list of movies that possibly match the search query.
    func searchForMovie(named title: String) async throws -> [Movie] {
        guard title.isEmpty == false else {
            throw SearchError.emptyQuery
        }
        
        let parameters: Parameters = [
            "query": title,
            "include_adult": true
        ]
        
        return try await AF.request(
            Endpoints.searchMovie,
            method: .get,
            parameters: parameters,
            headers: headers()
        )
        .serializingDecodable(MoviesResponse.self)
        .value
        .results
    }
    
    
    /// Creates the required headers for TMBD requests.
    ///
    /// - Returns: HTTPHeaders needed for TMBD requests.
    internal func headers() -> HTTPHeaders {
        return [
            .accept("application/json"),
            .contentType("application/json"),
            .authorization(bearerToken: Secrets.accessTokenAuthTMBD)
        ]
    }
}

final class MockTMBDGateway: TMBDGatewayProtocol {
    func updateMovieFavoriteStatus(for mediaId: Int, addToFavorites: Bool) async throws {
        throw UnknownError()
    }
    
    func favoriteMovies() async throws -> [Movie] {
        return [Movie.mock, Movie.mockNoPoster]
    }
    
    func searchForMovie(named title: String) async throws -> [Movie] {
        return [Movie.mock, Movie.mockNoPoster, Movie.mock]
    }
    
    func headers() -> HTTPHeaders {
        return []
    }
}
