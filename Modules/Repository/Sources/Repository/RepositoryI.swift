// The Swift Programming Language
// https://docs.swift.org/swift-book

import Domain

public protocol RepositoryI {
    func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO]
}

public protocol RemoteRepositoryI: RepositoryI { }

public protocol LocalRepositoryI: RepositoryI {
    func saveGames(_ games: [Domain.GameDTO]) async throws
    func deleteAllGames() async throws
}

public protocol RepositoryFacadeI: RemoteRepositoryI, LocalRepositoryI { }
