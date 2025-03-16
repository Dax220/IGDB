import XCTest
@testable import Repository
import Core
import Domain


final class RepositoryTests: XCTestCase {
    
    func testRemoteOnline() async throws {
        let remoteRepo = MockRepositoryFactory.shared.makeRepository()
        let remoteGame = try await remoteRepo.fetchGames(parameters: FetchGamesParameters(), remotely: true).first
        testGame(game: remoteGame)
    }
    
    func testFetchAndSaveDataForOfflineCase() async throws {
        let repo = MockRepositoryFactory.shared.makeRepository() as! MockRepositoryFacade
        let remoteGame = try await repo.fetchGames(parameters: FetchGamesParameters(), remotely: true).first
        try await repo.saveGames([remoteGame!])
        
        XCTAssertTrue(repo.fetchRemoteCalled == true)
        XCTAssertTrue(repo.fetchLocalCalled == false)
    
        let localGame = try await repo.fetchGames(parameters: FetchGamesParameters(), remotely: false).first
        
        XCTAssertTrue(repo.fetchRemoteCalled == false)
        XCTAssertTrue(repo.fetchLocalCalled == true)
        testGame(game: localGame)
    }
    
    func testGame(game: GameDTO?) {
        XCTAssertNotNil(game)
        XCTAssertEqual(game?.id, 173172)
        XCTAssertEqual(game?.coverImageURL, "https://images.igdb.com/igdb/image/upload/t_cover_big/co3yjh.png")
        XCTAssertEqual(game?.name, "Outer Wilds: Archaeologist Edition")
        XCTAssertEqual(game?.rating, "10")
        XCTAssertEqual(game?.ratingCount, 11)
        XCTAssertEqual(game?.aggregatedRating, "9")
        XCTAssertEqual(game?.aggregatedRatingCount, 3)
        XCTAssertEqual(Set(game?.genres ?? []), Set(["Puzzle", "Adventure", "Indie"]))
        XCTAssertEqual(Set(game?.platforms ?? []), Set(["Xbox Series X|S", "PlayStation 4", "PC (Microsoft Windows)"]))
        XCTAssertEqual(game?.summary, "Test summary")
        XCTAssertEqual(Set(game?.mainDevelopers ?? []), Set(["developer 1", "developer 2"]))
        XCTAssertEqual(Set(game?.portingDevelopers ?? []), Set(["porting 1", "porting 2"]))
        XCTAssertEqual(Set(game?.supportingDevelopers ?? []), Set(["supporting 1", "supporting 2"]))
        XCTAssertEqual(Set(game?.publishers ?? []), Set(["publisher 1", "publisher 2"]))
        XCTAssertEqual(Set(game?.themes ?? []), Set(["Theme 1", "Theme 2"]))
        XCTAssertEqual(Set(game?.gameModes ?? []), Set(["Mode 1", "Mode 2"]))
        XCTAssertEqual(Set(game?.playerPerspectives ?? []), Set(["Perspective 1", "Perspective 2"]))
        XCTAssertEqual(game?.storyline, "Test storyline")
        XCTAssertEqual(game?.videos?.first?.title, "Trailer")
        XCTAssertEqual(game?.videos?.first?.youtubeId, "yniQwQlyUl8")
        XCTAssertEqual(Set(game?.screenshots ?? []), Set([
            "https://images.igdb.com/igdb/image/upload/t_screenshot_med/scduy4.png",
            "https://images.igdb.com/igdb/image/upload/t_screenshot_med/scduy6.png",
            "https://images.igdb.com/igdb/image/upload/t_screenshot_med/scduy7.png"
        ]))
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
