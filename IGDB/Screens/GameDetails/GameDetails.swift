//
//  GameDetails.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI
import Domain


struct GameDetails: View {
    
    @ObservedObject var viewModel: GameDetailsViewModel
    
    @State var headerHeight: CGFloat?
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    ZStack(alignment: .bottom) {
                        
                        StretchyHeader(imageURL: viewModel.imageURL)
                        
                        HStack {
                            Text(viewModel.gameName)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(8)
                            Spacer()
                        }
                    }
                    
                    GameDetailsOverview()
                    
                    if let trailer = viewModel.trailer {
                        YouTubeVideoView(videoId: trailer.youtubeId)
                            .frame(height: 200)
                    }
                    
                    VStack {
                        CustomSegmentedControl(
                            selectedTab: $viewModel.selectedTab, items: [
                                .init(title: "segmented-control.about"),
                                .init(title: "segmented-control.videos"),
                                .init(title: "segmented-control.screenshots")
                            ]
                        )
                        .padding(8)
                    }
                    
                    VStack {
                        switch viewModel.selectedTab {
                        case .about:
                            GameDetailsAbout()
                        case .videos:
                            GameDetailsVideos()
                        case .screenshots:
                            GameDetailsScreenshots()
                        case .releases:
                            EmptyView()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            BackButton()
        }
        .environmentObject(viewModel)
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameDetails(viewModel: GameDetailsViewModel(game: GameDTO.dummy))
}
