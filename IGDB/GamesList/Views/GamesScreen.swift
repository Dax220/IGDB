//
//  GamesScreen.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI
import Domain

struct GamesScreen: View {
    
    @ObservedObject var viewModel: GamesListViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.loadingState == .initialLoading {
                    VStack {
                        ProgressView("gamesscreen.loading")
                            .progressViewStyle(.circular)
                            .font(.subheadline)
                    }
                } else {
                    GamesList()
                }
            }
            .overlay {
                if viewModel.loadingState == .initialLoadingError {
                    GamesListUnavailable()
                }
            }
            .onAppear {
                viewModel.loadGames()
            }
            .environmentObject(viewModel)
        }
        .animation(.spring(duration: 0.1), value: viewModel.loadingState)
    }
}

#Preview {
    GamesListFactory.makeView()
        .environmentObject(GamesListFactory.makeViewModel())
}
