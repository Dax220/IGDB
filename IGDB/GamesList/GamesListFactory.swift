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
        let repository = DIContainer.shared.resolve(RepositoryFacadeI.self)
        return GamesListViewModel(repository: repository)
    }
}
