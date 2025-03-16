//
//  GameDetailsFactory.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import Foundation
import Domain

class GameDetailsFactory {
    
    static func makeView(for game: GameDTO) -> GameDetails {
        let viewModel = GameDetailsViewModel(game: game)
        return GameDetails(viewModel: viewModel)
    }
}
