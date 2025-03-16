//
//  GamesList.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI
import Domain

struct GamesList: View {
    
    @EnvironmentObject var viewModel: GamesListViewModel
    @Environment(\.navigationPath) private var path
    
    private let gridLayout = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: gridLayout) {
                
                ForEach(viewModel.games) { game in
                    GamesListViewItem(game: game)
                        .onTapGesture {
                            path.wrappedValue.append(Screen.gameDetails(game))
                        }
                }
                
                if !viewModel.games.isEmpty {
                    GamesListProgressItem()
                }
            }
            .padding(.horizontal, 20)
        }
        .refreshable {
            viewModel.loadGames()
        }
    }
}

#Preview {
    let viewModel = GamesListFactory.makeViewModel()
    GamesList()
        .environmentObject(viewModel)
}
