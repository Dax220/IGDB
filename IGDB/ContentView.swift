//
//  ContentView.swift
//  IGDB
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import SwiftUI
import Domain

enum Screen: Equatable, Hashable {
    case gameDetails(GameDTO)
}

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            GamesListFactory.makeView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .gameDetails(let game):
                        GameDetailsFactory.makeView(for: game)
                    }
                }
        }
        .environment(\.navigationPath, $path)
    }
}

#Preview {
    ContentView()
}
