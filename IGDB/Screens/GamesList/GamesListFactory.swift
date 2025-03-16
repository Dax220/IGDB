//
//  GamesListFactory.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import Foundation
import Repository
import Core

class GamesListFactory {
    
    static func makeView() -> GamesScreen {
        let viewModel = makeViewModel()
        return GamesScreen(viewModel: viewModel)
    }
    
    static func makeViewModel() -> GamesListViewModel {
        let repository = DIContainer.shared.resolve(RepositoryFacadeI.self)
        let networkMonitor = DIContainer.shared.resolve(NetworkMonitorI.self)
        return GamesListViewModel(repository: repository, networkMonitor: networkMonitor)
    }
}
