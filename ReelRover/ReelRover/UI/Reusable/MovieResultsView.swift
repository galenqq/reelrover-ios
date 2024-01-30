import SwiftUI

/// View that displays movie in a list.
struct MovieResultsView: View {
    
    var movies: [Movie]
    
    /// This is a temporary solution to resolve a SwiftUI issue where `.task`, and `.onAppear` are not called
    /// when popping a `NavigationLink`. Since these modifiers are not called, `FavoritesView` is never updated.
    ///
    /// Given more time, creating a repository layer that utilizes `Combine`, between the ViewModels and Gateways
    /// would provide a better source of truth for which movies are favorited or not. 
    var favoritesUpdated: (() -> Void)?
    
    var body: some View {
        List(movies, id: \.id) { movie in
            NavigationLink {
                MovieDetailView(movie: movie, favoritesUpdated: favoritesUpdated)
            } label: {
                MovieCell(movie: movie)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    MovieResultsView(
        movies: [
            Movie.mock,
            Movie.mock
        ]
    )
}
