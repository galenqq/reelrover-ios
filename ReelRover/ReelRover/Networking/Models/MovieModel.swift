import Foundation
import SwiftData

/// Our model used to store movie data via `SwiftData`.
@Model class MovieModel {
    @Attribute(.unique) var id: Int { movie.id }
    
    /// We track timestamp as `SwiftData` does not maintain an order when being inserted.
    var timestamp: Date
    var movie: Movie
    
    init(timestamp: Date, movie: Movie) {
        self.timestamp = timestamp
        self.movie = movie
        
        // I believe there is a bug with SwiftData which makes it unable to handle some nil values.
        // We set a default value for these paths to ensure the model is stored.
        if self.movie.backdrop_path == nil {
            self.movie.backdrop_path = ""
        }
        
        if self.movie.poster_path == nil {
            self.movie.poster_path = ""
        }
    }
}
