import XCTest
import Alamofire
@testable import ReelRover

final class TMBDGatewayTests: XCTestCase {
    
    private var gateway: TMBDGatewayProtocol!

    override func setUp() {
        gateway = TMBDGateway()
    }
    
    func testEmptyQueryThrowsError() async {
        do {
            _ = try await gateway.searchForMovie(named: "")
            XCTFail("Should have thrown error.")
        } catch let error {
            XCTAssertEqual(error as? SearchError, SearchError.emptyQuery)
        }
    }
    
    func testExampleQueryReturnsMocks() async {
        gateway = MockTMBDGateway()
        
        do {
            let mocks = try await gateway.searchForMovie(named: "example movie")
            
            let expectedMocks = [Movie.mock, Movie.mockNoPoster, Movie.mock]
            XCTAssertEqual(mocks, expectedMocks)
        } catch {
            XCTFail("Should not have thrown error.")
        }
    }
    
    func testUpdateMovieFavoriteStatusThrowsError() async {
        gateway = MockTMBDGateway()
        
        do {
            try await gateway.updateMovieFavoriteStatus(for: 0, addToFavorites: true)
            XCTFail("Should have thrown error.")
        } catch is UnknownError {
            XCTAssertTrue(true)
        } catch {
            XCTFail("Should have thrown an unknown error.")
        }
    }
    
    func testFavoriteMoviesReturnsMocks() async throws {
        gateway = MockTMBDGateway()
        let movies = try await gateway.favoriteMovies()
        XCTAssertEqual(movies, [Movie.mock, Movie.mockNoPoster])
    }
}



