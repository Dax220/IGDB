import XCTest
@testable import Repository
import Foundation

final class RepositoryTests: XCTestCase {

    func testRemoteRepository() async throws {
        let repo = RemoteRepository(
            apiCalypseBuilder: APICalypseBuilder(),
            wrapper: MockAsyncIGDBWrapper(),
            mapper: RemoteGamesMapper(
                ratingFormatter: RatingFormatter()
            )
        )
        let game = try await repo.fetchGames(parameters: FetchGamesParameters()).first
        XCTAssertNotNil(game)
        XCTAssertEqual(game!.id, 199038)
        XCTAssertEqual(game!.coverImageId, "co4pg0")
        XCTAssertEqual(game!.name, "San Andreas Multiplayer")
        XCTAssertEqual(game!.rating, "10")
        XCTAssertEqual(Set(game!.genres ?? []), Set(["Racing", "Shooter"]))
    }
    
    func testAPICalypseBuilder() {
        let builder = APICalypseBuilder()
        let parameters = FetchGamesParameters(
            fields: [.name, .rating],
            sorting: GameSorting(gameField: .rating, order: .asc),
            limit: 10,
            offset: 20
        )
        let query = builder.buildApiCalypse(parameters: parameters).buildQuery()
        XCTAssertTrue(query.contains("f name,rating;"))
        XCTAssertTrue(query.contains("s rating asc;"))
        XCTAssertTrue(query.contains("l 10;"))
        XCTAssertTrue(query.contains("o 20;"))
    }
    
    func testRatingFormatter() {
        let formatter = RatingFormatter()
        XCTAssertEqual(formatter.roundRating(value: 99.51), "10")
        XCTAssertEqual(formatter.roundRating(value: 99.5), "10")
        XCTAssertEqual(formatter.roundRating(value: 99.49), "9.9")
    }
}
