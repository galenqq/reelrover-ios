import Foundation

/// Network model returned from the TMBD API.
struct Movie: Codable, Equatable {
    let adult: Bool?
    var backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    var poster_path: String?
    let release_date: String
    let title: String
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

// Helpers
extension Movie {
    var posterURL: URL? {
        guard let path = poster_path else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
    
    var backdropURL: URL? {
        guard let path = backdrop_path else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
    
    var localizedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let releaseDate = dateFormatter.date(from: release_date) else {
            return release_date
        }
        
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: releaseDate)
    }
}

// Mocks
extension Movie {
    static var mock: Movie {
        .init(
            adult: false,
            backdrop_path: nil,
            genre_ids: [],
            id: 0,
            original_language: "",
            original_title: "",
            overview: "",
            popularity: 1.0,
            poster_path: "/9sUaiIcnRpDUZTOBQP2cSt3G6a0.jpg",
            release_date: "2024-04-18",
            title: "Movie Title Example",
            video: false,
            vote_average: 0.0,
            vote_count: 0
        )
    }
    
    static var mockNoPoster: Movie {
        var mock = Movie.mock
        mock.poster_path = ""
        return mock
    }
}
