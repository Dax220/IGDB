//
//  MockRepositoryFacade.swift
//  Repository
//
//  Created by Maxim Tischenko on 16.03.2025.
//

@testable import Repository
import Domain

class MockRepositoryFacade: RepositoryFacade {
    
    var fetchRemoteCalled = false
    var fetchLocalCalled = false
    
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
}
