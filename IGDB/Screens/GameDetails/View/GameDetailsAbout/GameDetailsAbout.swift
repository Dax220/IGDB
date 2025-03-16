//
//  GameDetailsAbout.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI
import Domain

struct GameDetailsAbout: View {
    
    @EnvironmentObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        
        VStack {
            VStack {
                
                Grid {
                    
                    let items = viewModel.aboutImes
                    let columns = viewModel.numberOfAboutCollumns
                    let rows = viewModel.numberOfAboutRows
                    
                    ForEach(0..<rows, id: \.self) { row in
                        GridRow {
                            ForEach(0..<columns, id: \.self) { column in
                                let index = row * columns + column
                                if index < items.count {
                                    GameAboutTextItem(
                                        title: items[index].0,
                                        values: items[index].1
                                    )
                                }
                            }
                        }
                    }
                }
                
                if let storyline = viewModel.storyline {
                    Divider()
                    ExpandableText(storyline)
                        .font(.caption)
                }
            }
            .padding(8)
            .background(.white)
            .shadow(radius: 5)
        }
        .padding(8)
    }
}

#Preview {
    GameDetailsAbout()
        .environmentObject(
            GameDetailsViewModel(game: GameDTO.dummy))
}
