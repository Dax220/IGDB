//
//  GameDetailsViewModel.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import Foundation
import Domain
import SwiftUI

typealias AboutItem = (LocalizedStringKey, [String])

enum GameAboutTabs: Int {
    case about
    case videos
    case screenshots
    case releases
}

class GameDetailsViewModel: ObservableObject {
    
    @Published var gameName: String
    @Published var imageURL: URL
    @Published var rating: String
    @Published var ratingCount: Int?
    @Published var aggregatedRating: String?
    @Published var aggregatedRatingCount: Int?
    @Published var genre: String?
    @Published var genres: [String]
    @Published var platforms: String?
    @Published var summary: String?
    @Published var aboutImes: [AboutItem] = []
    @Published var storyline: String?
    @Published var videos: [VideoDTO]
    @Published var trailer: VideoDTO?
    @Published var screenshots: [String]
    
    @Published var selectedTab: GameAboutTabs = .about
    
    var numberOfAboutCollumns = 2
    var numberOfAboutRows: Int {
        (aboutImes.count + numberOfAboutCollumns - 1) / numberOfAboutCollumns
    }
    
    init(game: GameDTO) {
        gameName = game.name
        imageURL = URL(string: game.coverImageURL ?? "")!
        rating = game.rating
        ratingCount = game.ratingCount
        aggregatedRating = game.aggregatedRating
        aggregatedRatingCount = game.aggregatedRatingCount
        genre = game.genres?.joined(separator: ", ")
        genres = game.genres ?? []
        platforms = game.platforms?.joined(separator: ", ")
        summary = game.summary
        storyline = game.storyline
        videos = game.videos ?? []
        trailer = game.videos?.last
        screenshots = game.screenshots ?? []
        
        buildAboutItems(game: game)
    }
    
    private func buildAboutItems(game: GameDTO) {
        let mainDevelopers = game.mainDevelopers ?? []
        let portingDevelopers = game.portingDevelopers ?? []
        let supportingDevelopers = game.supportingDevelopers ?? []
        let publishers = game.publishers ?? []
        let themes = game.themes ?? []
        let modes = game.gameModes ?? []
        let playerPerspectives = game.playerPerspectives ?? []
        
        aboutImes = [
            ("game.about.item.main-developers", mainDevelopers),
            ("game.about.item.porting-developers", portingDevelopers),
            ("game.about.item.supporting-developers", supportingDevelopers),
            ("game.about.item.publishers", publishers),
            ("game.about.item.genres", genres),
            ("game.about.item.themes", themes),
            ("game.about.item.modes", modes),
            ("game.about.item.playerPerspectives", playerPerspectives)
        ].filter { !$0.1.isEmpty }
    }
}
