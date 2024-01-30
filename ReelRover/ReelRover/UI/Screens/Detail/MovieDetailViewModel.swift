import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    /// The gateway used to access the TMBD API.
    /// Given more time, I would introduce a proper DI system, and avoid singletons where possible.
    var gateway: TMBDGatewayProtocol = TMBDGateway.shared
    
    // MARK: - State
    
    /// Whether or not this movie is favorited.
    @Published var isFavorited = false
    
    /// Error state of the screen.
    @Published var error: Error?
    
    // MARK: - Functions
    
    /// Retrieves and loads in favorited movies.
    ///
    /// - Parameter movieId: The id of the movie we are checking.
    func checkFavoriteStatus(for movieId: Int) async {
        guard let favoritedMovies = try? await gateway.favoriteMovies() else {
            // If operation fails, we return favorite to its prior state
            isFavorited.toggle()
            return
        }
        
        isFavorited = favoritedMovies.contains(where: { $0.id == movieId })
    }
    
    /// We update the favorite status based on whether it is currently favorited or not. 
    ///
    /// - Parameter movieId: The id of the movie we are checking.
    func updateFavoriteStatus(for movieId: Int) async {
        let shouldAddToFavorites = !isFavorited
        
        // We optimistically change the UI assuming the operation will work.
        isFavorited.toggle()
        
        do {
            try await gateway.updateMovieFavoriteStatus(
                for: movieId,
                addToFavorites: shouldAddToFavorites
            )
        } catch let error {
            // If there is an error we change it back.
            isFavorited.toggle()
            self.error = error
            return
        }
        
        // We also do a final check of checking the source of truth (favorites list)
        // so that we are sure our movie is on there.
        await checkFavoriteStatus(for: movieId)
    }
}
