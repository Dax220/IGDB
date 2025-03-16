//
//  GamesListViewItem.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI
import Domain


struct GamesListViewItem: View {
    
    @State var height: CGFloat = 250
    var game: GameDTO
    
    init(game: GameDTO) {
        self.game = game
    }
    
    var body: some View {
        ZStack {
            
            Color.white
            
            VStack {
                
                CachedAsyncImage(
                    url: URL(string: game.coverImageURL ?? "")!,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                    }, placeholder: {
                        Image("emptyImage")
                            .resizable()
                    }
                )
                .frame(height: height)
                
                Spacer()
                
                VStack(spacing: 4) {
                    
                    HStack {
                        Text(game.name)
                            .font(.headline)
                        Spacer()
                    }
                    
                    HStack(spacing: 4) {
                        Text(game.genres?.first ?? "")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(game.rating)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Image("star")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                }
                .lineLimit(1)
                .padding(8)
            }
        }
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

#Preview {
    GamesListViewItem(game: GameDTO.dummy)
}
