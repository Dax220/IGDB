//
//  MockRepositoryFacade.swift
//  Repository
//
//  Created by Maxim Tischenko on 16.03.2025.
//


import Domain

class MockRepositoryFacade: RepositoryFacade {
    
    var fetchRemoteCalled = false
    var fetchLocalCalled = false
    var deleteGamesCalled = false
    var saveGamesCalled = false
    
    func reset() {
        fetchRemoteCalled = false
        fetchLocalCalled = false
        deleteGamesCalled = false
        saveGamesCalled = false
    }
    
    override func fetchRemotely(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        fetchRemoteCalled = true
        fetchLocalCalled = false
        return try await super.fetchRemotely(parameters: parameters)
    }
    
    override func fetchLocaly(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        fetchRemoteCalled = false
        fetchLocalCalled = true
        return try await super.fetchLocaly(parameters: parameters)
    }
    
    override func deleteAllGames() async throws {
        deleteGamesCalled = true
        try await super.deleteAllGames()
    }
    
    override func saveGames(_ games: [GameDTO]) async throws {
        saveGamesCalled = true
        try await super.saveGames(games)
    }
}
