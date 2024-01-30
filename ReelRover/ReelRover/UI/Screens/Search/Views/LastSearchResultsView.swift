import SwiftUI
import SwiftData


/// Utilizes `SwiftData` to query for stored movies from th last search.
struct LastSearchResultsView: View {
    
    // MARK: - SwiftData
    
    @Query(sort: \MovieModel.timestamp) var lastSearchResults: [MovieModel]
    
    // MARK: - CoreData
    
    var body: some View {
        List {
            Section {
                ForEach(lastSearchResults) { result in
                    NavigationLink {
                        MovieDetailView(movie: result.movie)
                    } label: {
                        MovieCell(movie: result.movie)
                    }
                }
            } header: {
                header
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    private var header: some View {
        if lastSearchResults.isEmpty == false {
            Text("Last Search Results")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .padding(.leading)
                .padding(.vertical, 7)
        }
    }
}

#Preview {
    LastSearchResultsView()
}
