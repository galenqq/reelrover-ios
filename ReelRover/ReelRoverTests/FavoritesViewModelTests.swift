import XCTest
@testable import ReelRover

@MainActor
final class FavoritesViewModelTests: XCTestCase {
    
    private var viewModel: FavoritesViewModel!

    override func setUp() {
        viewModel = FavoritesViewModel()
        viewModel.gateway = MockTMBDGateway()
    }
    
    func testLoadReturnsMocksFromGateway() async {
        XCTAssertTrue(viewModel.favoritedMovies.isEmpty)
        await viewModel.load()
        XCTAssertEqual(viewModel.favoritedMovies, [Movie.mock, Movie.mockNoPoster])
    }
}
