//
//  Videos.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct GameDetailsVideos: View {
    
    @EnvironmentObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        LazyVStack {
            
            ForEach(viewModel.videos, id: \.self) { video in
                
                VStack(alignment: .leading, spacing: 4) {
                    if let title = video.title {
                        Text(title)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .frame(alignment: .leading)
                    }
                    YouTubeVideoView(videoId: video.youtubeId)
                        .frame(height: 200)
                }
            }
        }
    }
}
