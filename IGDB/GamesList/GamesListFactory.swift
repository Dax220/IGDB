//
//  GamesListFactory.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import Foundation
import Repository

class GamesListFactory {
    
    static func makeView() -> GamesScreen {
        let viewModel = makeViewModel()
        return GamesScreen(viewModel: viewModel)
    }
    
    static func makeViewModel() -> GamesListViewModel {
        let repositoryFactory = RepositoryFactory()
        return GamesListViewModel(repositoryFactory: repositoryFactory)
    }
}
