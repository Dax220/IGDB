//
//  GamesListProgressItem.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI

struct GamesListProgressItem: View {
    
    @EnvironmentObject var viewModel: GamesListViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 200)
            
            if viewModel.loadingState == .batchLoadingError {
                Button("progressitem.title") {
                    viewModel.loadMoreGames()
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        viewModel.loadMoreGames()
                    }
            }
        }
        .cornerRadius(5)
    }
}

#Preview {
    GamesListProgressItem()
        .environmentObject(GamesListFactory.makeViewModel())
}
