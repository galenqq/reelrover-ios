import XCTest
@testable import ReelRover

@MainActor
final class MovieDetailViewModelTests: XCTestCase {
    
    private var viewModel: MovieDetailViewModel!

    override func setUp() {
        viewModel = MovieDetailViewModel()
        viewModel.gateway = MockTMBDGateway()
    }
    
    func testFavoriteStatusCheckUpdatesIsFavorited() async {
        XCTAssertFalse(viewModel.isFavorited)
        viewModel.isFavorited = true
        await viewModel.checkFavoriteStatus(for: -1)
        XCTAssertFalse(viewModel.isFavorited)
    }
    
    func testFailedUpdateFavoriteStatusRestoresFavoriteFlag() async {
        XCTAssertFalse(viewModel.isFavorited)
        await viewModel.updateFavoriteStatus(for: 0)
        XCTAssertFalse(viewModel.isFavorited)
    }
}
