//
//  GameOverview.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct GameDetailsOverview: View {
    
    @EnvironmentObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 8) {
                
                if let genre = viewModel.genre, !genre.isEmpty {
                    GameDetailsTextPair(
                        topText: String(localized: "game-details.genre"),
                        bottomText: genre
                    )
                }
                
                if let platforms = viewModel.platforms {
                    GameDetailsTextPair(
                        topText: String(localized: "game-details.platforms"),
                        bottomText: platforms
                    )
                }
                
                GameDetailsRatingView()
                
                if let summary = viewModel.summary {
                    ExpandableText(summary)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding(8)
            .background(.appGrayBackground)
        }
        .frame(alignment: .leading)
    }
}
