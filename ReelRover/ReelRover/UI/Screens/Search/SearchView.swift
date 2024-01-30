import SwiftUI

struct SearchView: View {
    
    // MARK: - Environment
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.isSearching) var isSearching
    
    // MARK: - State
    
    @StateObject private var viewModel = SearchViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.movieSearchResults.isEmpty {
                    LastSearchResultsView()
                } else {
                    MovieResultsView(movies: viewModel.movieSearchResults)
                }
            }
            .navigationTitle("ReelRover")
        }
        .loader($viewModel.isLoading)
        .alert($viewModel.error)
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search movies by title"
        )
        .onSubmit(of: .search) {
            guard viewModel.searchQuery.isEmpty == false else {
                return
            }
            
            Task {
                // 1. We clear the prior last search results.
                try? modelContext.delete(model: MovieModel.self)
                
                // 2. We retrieve search results via TMBD API, and then we store them via SwiftData.
                for movie in await viewModel.searchForMovie() {
                    modelContext.insert(movie)
                }
                
                // 3. We save the context if the new models have been successfully inserted.
                if modelContext.hasChanges {
                    try? modelContext.save()
                }
            }
        }
        .onChange(of: isSearching) {
            // We do this because SwiftUI does not offer a completion for the `.searchable` cancel button.
            // This is not the nicest way of clearing search results, but
            // at the moment this is a SwiftUI limitation.
            if !$0 { viewModel.movieSearchResults = [] }
        }
    }
}

#Preview {
    SearchView()
}
