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
    private let networkMonitor: NetworkMonitorI
    
    private var isInternetAvailable: Bool {
        return networkMonitor.isConnected
    }
    
    init(
        remoteRepository: RepositoryI,
        localRepository: LocalRepositoryI,
        networkMonitor: NetworkMonitorI
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
        self.networkMonitor = networkMonitor
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
