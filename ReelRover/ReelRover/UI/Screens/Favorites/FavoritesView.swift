import SwiftUI

struct FavoritesView: View {
    
    // MARK: - State
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if
                    viewModel.favoritedMovies.isEmpty,
                    !viewModel.isLoading
                {
                    Text("No favorites yet!")
                        .font(.title)
                        .bold()
                } else {
                    MovieResultsView(movies: viewModel.favoritedMovies) {
                        Task { await viewModel.load() }
                    }
                }
            }
            .navigationTitle("Favorites")
            .refreshable { await viewModel.load(isRefreshing: true) }
        }
        .loader($viewModel.isLoading)
        .alert($viewModel.error)
        .onAppear { Task { await viewModel.load() } }
    }
}
