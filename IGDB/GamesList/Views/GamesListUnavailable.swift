//
//  GamesListUnavailable.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI

struct GamesListUnavailable: View {
    
    @EnvironmentObject var viewModel: GamesListViewModel
    
    var body: some View {
        ContentUnavailableView(label: {
            Label("gamesunavailable.title", systemImage: "gamecontroller")
        }, description: {
            Text("gamesunavailable.description")
        }, actions: {
            Button("gamesunavailable.action.title") {
                viewModel.loadGames()
            }
        })
    }
}

#Preview {
    GamesListUnavailable()
}
