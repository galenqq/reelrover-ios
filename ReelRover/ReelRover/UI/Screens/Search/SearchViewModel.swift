import Foundation

@MainActor 
final class SearchViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    /// The gateway used to access the TMBD API.
    /// Given more time, I would introduce a proper DI system, and avoid singletons where possible.
    var gateway: TMBDGatewayProtocol = TMBDGateway.shared
    
    // MARK: - State
    
    /// The query that we use to search for movies via the TMBD API.
    @Published var searchQuery = "" {
        // We reset the movie search results whenever the search query becomes empty.
        didSet { if searchQuery.isEmpty { movieSearchResults = [] } }
    }
    
    /// Search results from network.
    @Published var movieSearchResults: [Movie] = []
    
    /// Loading state of the screen.
    @Published var isLoading = false
    
    /// Error state of the screen.
    @Published var error: Error?
    
    
    // MARK: - Functions
    
    /// Searches for a movie based on the `searchQuery`.
    /// 
    /// - Returns: The models needed to be saved by `SwiftData`.
    func searchForMovie() async -> [MovieModel] {
        isLoading = true
        defer { isLoading = false }
        do {
            let results = try await gateway.searchForMovie(named: searchQuery)
            
            // The network response can be a success, but have no results.
            // For the sake of simplicity, we will throw an error here letting the user know.
            guard !results.isEmpty else {
                throw SearchError.noResults
            }
            
            movieSearchResults = results
            
            // Normally, we'd simply update the state, but in an effort to store the last search result's data locally,
            // we will send these values to the view so they can be stored via SwiftData.
            return movieSearchResults.map { MovieModel(timestamp: Date(), movie: $0) }
            
        } catch let error {
            self.error = error
            return []
        }
    }
}

enum SearchError: LocalizedError {
    case noResults, emptyQuery
    
    var failureReason: String? { "Oops..." }
    
    var errorDescription: String? {
        switch self {
        case .noResults: return "We couldn't find any movies with that title! Please try searching again."
        case .emptyQuery: return "Please enter a movie title searching."
        }
    }
}
