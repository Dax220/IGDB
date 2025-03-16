//
//  IGDBTests.swift
//  IGDBTests
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import XCTest
@testable import IGDB
@testable import Repository

final class IGDBTests: XCTestCase {

    func testLoadItemsOnline() async throws {
        let repo = MockRepositoryFactory.shared.makeRepository() as! MockRepositoryFacade
        let networkMonitor = MockRepositoryFactory.shared.makeNetworkMonitor() as! MockNetworkMonitor
        MockNetworkMonitor.isNetworkAvailable = true
        repo.reset()
        _ = GamesListViewModel(repository: repo, networkMonitor: networkMonitor)
        
        try await Task.sleep(for: .seconds(1))
        
        XCTAssertEqual(repo.fetchRemoteCalled, true)
        XCTAssertEqual(repo.fetchLocalCalled, false)
        XCTAssertEqual(repo.deleteGamesCalled, true)
        XCTAssertEqual(repo.saveGamesCalled, true)
    }
    
    func testLoadItemsOffline() async throws {
        let repo = MockRepositoryFactory.shared.makeRepository() as! MockRepositoryFacade
        let networkMonitor = MockRepositoryFactory.shared.makeNetworkMonitor() as! MockNetworkMonitor
        MockNetworkMonitor.isNetworkAvailable = false
        repo.reset()
        _ = GamesListViewModel(repository: repo, networkMonitor: networkMonitor)
        
        try await Task.sleep(for: .seconds(1))
        
        XCTAssertEqual(repo.fetchRemoteCalled, false)
        XCTAssertEqual(repo.fetchLocalCalled, true)
        XCTAssertEqual(repo.deleteGamesCalled, false)
        XCTAssertEqual(repo.saveGamesCalled, false)
    }
    
    func testLoadMoreGamesOnline() async throws {
        let repo = MockRepositoryFactory.shared.makeRepository() as! MockRepositoryFacade
        let networkMonitor = MockRepositoryFactory.shared.makeNetworkMonitor() as! MockNetworkMonitor
        MockNetworkMonitor.isNetworkAvailable = true
        
        let viewModel = GamesListViewModel(repository: repo, networkMonitor: networkMonitor)
        
        try await Task.sleep(for: .seconds(1))
        
        repo.reset()
        viewModel.loadingState = .loaded
        viewModel.loadMoreGames()
        try await Task.sleep(for: .seconds(1))
        
        XCTAssertEqual(repo.fetchRemoteCalled, true)
        XCTAssertEqual(repo.fetchLocalCalled, false)
        XCTAssertEqual(repo.deleteGamesCalled, false)
        XCTAssertEqual(repo.saveGamesCalled, true)
    }
    
    func testLoadMoreGamesOffline() async throws {
        let repo = MockRepositoryFactory.shared.makeRepository() as! MockRepositoryFacade
        let networkMonitor = MockRepositoryFactory.shared.makeNetworkMonitor() as! MockNetworkMonitor
        MockNetworkMonitor.isNetworkAvailable = false
        
        let viewModel = GamesListViewModel(repository: repo, networkMonitor: networkMonitor)
        
        try await Task.sleep(for: .seconds(1))
        
        repo.reset()
        viewModel.loadingState = .loaded
        viewModel.loadMoreGames()
        try await Task.sleep(for: .seconds(1))
        
        XCTAssertEqual(repo.fetchRemoteCalled, false)
        XCTAssertEqual(repo.fetchLocalCalled, true)
        XCTAssertEqual(repo.deleteGamesCalled, false)
        XCTAssertEqual(repo.saveGamesCalled, false)
    }
}
