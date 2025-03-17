//
//  RemoteGamesMapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Domain
import IGDB_SWIFT_API

class RemoteGamesMapper {
    
    private let ratingFormatter: RatingFormatter
    
    init(ratingFormatter: RatingFormatter) {
        self.ratingFormatter = ratingFormatter
    }
    
    func mapFromServerDTO(_ serverDTO: GameServerDTO) -> GameDTO {
        GameDTO(
            id: serverDTO.id,
            coverImageURL: imageBuilder(imageID: serverDTO.cover?.imageId ?? "", size: .COVER_BIG),
            name: serverDTO.name,
            rating: serverDTO.rating == nil
                ? nil
                : ratingFormatter.roundRating(value: serverDTO.rating!),
            ratingCount: serverDTO.ratingCount,
            aggregatedRating: serverDTO.aggregatedRating == nil
                ? nil
                : ratingFormatter.roundRating(value: serverDTO.aggregatedRating!),
            aggregatedRatingCount: serverDTO.aggregatedRatingCount,
            genres: serverDTO.genres?.map(\.name),
            platforms: serverDTO.platforms?.map(\.name),
            summary: serverDTO.summary,
            mainDevelopers: serverDTO.involvedCompanies?.filter({ $0.developer }).map(\.company.name),
            portingDevelopers: serverDTO.involvedCompanies?.filter({ $0.porting }).map(\.company.name),
            supportingDevelopers: serverDTO.involvedCompanies?.filter({ $0.supporting }).map(\.company.name),
            publishers: serverDTO.involvedCompanies?.filter({ $0.publisher }).map(\.company.name),
            themes: serverDTO.themes?.map(\.name),
            gameModes: serverDTO.gameModes?.map(\.name),
            playerPerspectives: serverDTO.playerPerspectives?.map(\.name),
            storyline: serverDTO.storyline,
            videos: serverDTO.videos?.map({VideoDTO(youtubeId: $0.videoId, title: $0.name)}),
            screenshots: serverDTO.screenshots?.map({imageBuilder(imageID: $0.imageId, size: .SCREENSHOT_MEDIUM)})
        )
    }
}
