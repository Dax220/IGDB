// The Swift Programming Language
// https://docs.swift.org/swift-book

import Domain

public protocol Repository {
    func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO]
}

protocol RemoteRepositoryI: Repository {
    
}

protocol LocalRepositoryI: Repository {
    
}
