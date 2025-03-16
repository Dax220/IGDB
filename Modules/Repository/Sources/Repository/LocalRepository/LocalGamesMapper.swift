//
//  LocalGamesMapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import CoreData
import Domain

class LocalGamesMapper {
    
    func map(from game: Game) -> GameDTO {
        GameDTO(
            id: Int(game.id),
            coverImageURL: game.coverImageURL,
            name: game.name ?? "",
            rating: game.rating ?? "",
            ratingCount: Int(game.ratingCount),
            aggregatedRating: game.aggregatedRating,
            aggregatedRatingCount: Int(game.aggregatedRatingCount),
            genres: game.genres as? [String],
            platforms: game.platforms as? [String],
            summary: game.summary,
            mainDevelopers: game.mainDevelopers as? [String],
            portingDevelopers: game.portingDevelopers as? [String],
            supportingDevelopers: game.supportingDevelopers as? [String],
            publishers: game.publishers as? [String],
            themes: game.themes as? [String],
            gameModes: game.gameModes as? [String],
            playerPerspectives: game.playerPerspectives as? [String],
            storyline: game.storyline,
            videos: (game.videos as! Set<Video>).map({VideoDTO(youtubeId: $0.videoId!, title: $0.title)}),
            screenshots: game.screenshots as? [String]
        )
    }
}
