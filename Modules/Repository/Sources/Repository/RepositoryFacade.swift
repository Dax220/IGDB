//
//  File.swift
//  Repository
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Foundation
import Domain
import Core

class RepositoryFacade: RepositoryFacadeI {
    
    private let remoteRepository: RepositoryI
    private let localRepository: LocalRepositoryI
    
    init(
        remoteRepository: RepositoryI,
        localRepository: LocalRepositoryI
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    public func fetchGames(parameters: FetchGamesParameters, remotely: Bool) async throws -> [GameDTO] {
        if remotely {
            return try await fetchRemotely(parameters: parameters)
        }
        try? await Task.sleep(nanoseconds: 500_000_000)
        return try await fetchLocaly(parameters: parameters)
    }
    
    public func saveGames(_ games: [GameDTO]) async throws {
        try await localRepository.saveGames(games)
    }
    
    public func deleteAllGames() async throws {
        try await localRepository.deleteAllGames()
    }
    
    internal func fetchRemotely(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        try await remoteRepository.fetchGames(parameters: parameters)
    }
    
    internal func fetchLocaly(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        try await localRepository.fetchGames(parameters: parameters)
    }
}
