//
//  File.swift
//  Repository
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Foundation
import Domain

class RepositoryFacade: RepositoryFacadeI {
    
    private let remoteRepository: RepositoryI
    private let localRepository: LocalRepositoryI
    
    private var isInternetAvailable: Bool {
        return true
    }
    
    init(remoteRepository: RepositoryI, localRepository: LocalRepositoryI) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    public func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        if isInternetAvailable {
            return try await remoteRepository.fetchGames(parameters: parameters)
        }
        return try await localRepository.fetchGames(parameters: parameters)
    }
    
    public func saveGames(_ games: [GameDTO]) async throws {
        if isInternetAvailable {
            try await localRepository.saveGames(games)
        }
    }
    
    public func deleteAllGames() async throws {
        if isInternetAvailable {
            try await localRepository.deleteAllGames()
        }
    }
}
