//
//  GameDetails.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI
import Domain

struct GameDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: GameDetailsViewModel
    
    @State var headerHeight: CGFloat?
    
    var body: some View {
        
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
                            .init(title: "About"),
                            .init(title: "Videos"),
                            .init(title: "Screenshots")
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
        .environmentObject(viewModel)
//        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Image(systemName: "chevron.left")
            .foregroundColor(.blue)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
        )
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    GameDetails(viewModel: GameDetailsViewModel(game: GameDTO.dummy))
}
