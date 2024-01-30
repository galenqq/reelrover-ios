import SwiftUI
import CachedImage

struct MovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            poster
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .bold()
                
                // Sometimes, the release date is empty, and not nil.
                // We shouldn't display anything here if there is no release date. 
                if !movie.release_date.isEmpty {
                    Text("Released \(movie.localizedReleaseDate)")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
        }
    }
    
    private var poster: some View {
        CachedImage(url: movie.posterURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            defaultPoster
        }
        .frame(maxWidth: 80)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .secondary, radius: 5)
    }
    
    private var defaultPoster: some View {
        Image(.defaultPoster)
            .resizable()
            .scaledToFit()
            .redacted(reason: .placeholder)
            .overlay {
                Image(systemName: "photo.fill")
            }
    }
}

#Preview {
    List {
        Group {
            MovieCell(movie: Movie.mock)
            MovieCell(movie: Movie.mock)
            MovieCell(movie: Movie.mockNoPoster)
            MovieCell(movie: Movie.mock)
        }
        .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
}
