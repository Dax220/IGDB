//
//  Screenshots.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct GameDetailsScreenshots: View {
    
    @EnvironmentObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        LazyVStack {
            
            ForEach(viewModel.screenshots, id: \.self) { screenshot in
                
                CachedAsyncImage(
                    url: URL(string: screenshot)!,
                    content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                    }, placeholder: {
                        Image("emptyImage")
                            .resizable()
                    }
                )
            }
        }
    }
}
