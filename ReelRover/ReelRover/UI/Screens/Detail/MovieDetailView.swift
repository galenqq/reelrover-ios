import SwiftUI

struct MovieDetailView: View {
    
    // MARK: - Init
    
    var movie: Movie
    var favoritesUpdated: (() -> Void)?
    
    // MARK: - State
    
    @StateObject private var viewModel = MovieDetailViewModel()
    
    // MARK: - Body
    
    var body: some View {
        List {
            Section {
                MovieCell(movie: movie)
                    .padding()
                
                favoriteButton
                
                if let overviewText = movie.overview, !overviewText.isEmpty {
                    overview(overviewText)
                }
            } header: {
                if let backdropURL = movie.backdropURL {
                    backdropHeader(backdropURL)
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .alert($viewModel.error)
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.checkFavoriteStatus(for: movie.id) }
    }
    
    private var favoriteButton: some View {
        Button {
            Task {
                await viewModel.updateFavoriteStatus(for: movie.id)
                if let favoritesUpdated { favoritesUpdated() }
            }
        } label: {
            HStack {
                Spacer()
                Label(
                    viewModel.isFavorited ? "Unfavorite" : "Favorite",
                    systemImage: viewModel.isFavorited ? "heart.fill" : "heart"
                )
                .foregroundStyle(.primary)
                .bold()
                .padding()
                Spacer()
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }
    
    // MARK: - Helpers
    
    /// Header with a movie backdrop.
    private func backdropHeader(_ url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image(.defaultBackdrop)
                .resizable()
                .scaledToFit()
                .redacted(reason: .placeholder)
        }
    }
    
    /// Movie overview summarizing the movie.
    private func overview(_ text: String) -> some View {
        Section {
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(25)
            
        } header: {
            Text("Overview")
                .font(.headline)
                .foregroundStyle(.secondary)
                .padding(.leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}
