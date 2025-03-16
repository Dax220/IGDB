//
//  GamesListViewModel.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import Foundation
import Repository
import Domain
import SwiftUI

class GamesListViewModel: ObservableObject {
    
    enum LoadingState {
        case initialLoading
        case batchloading
        case initialLoadingError
        case batchLoadingError
        case loaded
        
        var isLoading: Bool {
            self == .initialLoading || self == .batchloading
        }
    }
    
    @Published var games: [GameDTO] = []
    @Published var loadingState: LoadingState = .loaded
    
    private let limit = 10
    private var offset: Int {
        games.count
    }
    
    private let repository: RepositoryFacadeI
    
    init(repository: RepositoryFacadeI) {
        self.repository = repository
        loadGames()
    }
    
    func loadGames() {
        Task { @MainActor in
            guard !loadingState.isLoading else { return }
            setLoadingState(.initialLoading)
            do {
                let fetchedgames = try await fetchGames(limit: limit, offset: 0)
                self.games = fetchedgames
                if self.games.isEmpty {
                    setLoadingState(.initialLoadingError)
                    throw AppError.noGames
                }
                Task.detached(priority: .utility) {
                    try await self.repository.deleteAllGames()
                    try await self.repository.saveGames(fetchedgames)
                }
            } catch {
                games = []
                setLoadingState(.initialLoadingError)
            }
        }
    }
    
    func loadMoreGames() {
        Task { @MainActor in
            guard !loadingState.isLoading else { return }
            setLoadingState(.batchloading)
            do {
                let fetchedgames = try await fetchGames(limit: limit, offset: offset)
                games.append(contentsOf: fetchedgames)
                Task.detached(priority: .utility) {
                    try await self.repository.saveGames(fetchedgames)
                }
            } catch {
                setLoadingState(.batchLoadingError)
            }
        }
    }
    
    @MainActor
    private func fetchGames(limit: Int, offset: Int) async throws -> [GameDTO] {
        do {
            let games = try await repository.fetchGames(
                parameters: FetchGamesParameters(
                    fields: GameFields.allCases,
                    sorting: GameSorting(gameField: .rating, order: .desc),
                    limit: limit,
                    offset: offset
                )
            )
            setLoadingState(.loaded)
            return games
        } catch {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            throw error
        }
    }
    
    private func setLoadingState(_ state: LoadingState) {
        withAnimation {
            loadingState = state
        }
    }
}
