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
    
    private var repository: Repository {
        repositoryFactory.makeRemoteRepository()
    }
    
    private let repositoryFactory: RepositoryFactory
    
    init(repositoryFactory: RepositoryFactory) {
        self.repositoryFactory = repositoryFactory
    }
    
    func loadGames() {
        Task { @MainActor in
            guard !loadingState.isLoading else { return }
            withAnimation {
                loadingState = .initialLoading
            }
            do {
                games = try await fetchGames(limit: limit, offset: 0)
            } catch {
                games = []
                withAnimation {
                    loadingState = .initialLoadingError
                }
            }
        }
    }
    
    func loadMoreGames() {
        Task { @MainActor in
            guard !loadingState.isLoading else { return }
            withAnimation {
                loadingState = .batchloading
            }
            do {
                games += try await fetchGames(limit: limit, offset: offset)
            } catch {
                withAnimation {
                    loadingState = .batchLoadingError
                }
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
            withAnimation {
                loadingState = .loaded
            }
            return games
        } catch {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            throw error
        }
    }
}
