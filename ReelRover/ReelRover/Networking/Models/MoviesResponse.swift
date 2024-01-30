/// Network response via `Endpoints.movieSearch(for: )`
struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
