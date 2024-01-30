import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    /// The gateway used to access the TMBD API.
    /// Given more time, I would introduce a proper DI system, and avoid singletons where possible.
    var gateway: TMBDGatewayProtocol = TMBDGateway.shared
    
    // MARK: - State
    
    /// Favorited movies from network.
    @Published var favoritedMovies: [Movie] = []
    
    /// Loading state of the screen.
    @Published var isLoading = false
    
    /// Error state of the screen.
    @Published var error: Error?
    
    // MARK: - Functions
    
    /// Retrieves and loads in favorited movies.
    /// 
    /// - Parameter isRefreshing: Whether this load was called from `refreshable` or not.
    func load(isRefreshing: Bool = false) async {
        if !isRefreshing { isLoading = true }
        defer { isLoading = false }
        do {
            favoritedMovies = try await gateway.favoriteMovies()
        } catch let error {
            self.error = error
        }
    }
}
