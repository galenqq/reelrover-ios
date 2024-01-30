import XCTest
@testable import ReelRover

@MainActor
final class SearchViewModelTests: XCTestCase {
    
    private var viewModel: SearchViewModel!

    override func setUp() {
        viewModel = SearchViewModel()
        viewModel.gateway = TMBDGateway()
    }
    
    func testEmptyQueryThrowsError() async {
        viewModel.searchQuery = ""
        _ = await viewModel.searchForMovie()
        XCTAssertEqual(viewModel.error as? SearchError, SearchError.emptyQuery)
    }
    
    func testExampleQueryReturnsMocks() async {
        viewModel.gateway = MockTMBDGateway()
        
        viewModel.searchQuery = "example movie"
        _ = await viewModel.searchForMovie()
            
        let expectedMocks = [Movie.mock, Movie.mockNoPoster, Movie.mock]
        XCTAssertEqual(viewModel.movieSearchResults, expectedMocks)
        XCTAssertNil(viewModel.error)
    }
    
    func testEmptySearchQueryClearsSearchResults() {
        
        viewModel.movieSearchResults = [Movie.mock, Movie.mockNoPoster, Movie.mock]
        
        viewModel.searchQuery = "example movie"
        
        XCTAssertEqual(viewModel.movieSearchResults, [Movie.mock, Movie.mockNoPoster, Movie.mock])
        
        viewModel.searchQuery = ""
        
        XCTAssertEqual(viewModel.movieSearchResults, [])
    }
}
