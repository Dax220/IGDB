//
//  GamesListViewItem.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI
import SDWebImageSwiftUI
import Domain

struct GamesListViewItem: View {
    
    var game: GameDTO
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                
                WebImage(url: URL(string: game.coverImageURL)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image("emptyImage")
                        .resizable()
                }
                .scaledToFit()
                
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
    GamesListViewItem(
        game: GameDTO(id: 1, coverImageURL: "", name: "The witcher 3: Wild Hunt", rating: "9.2", genres: ["Role-playing (RPG)"])
    )
}
