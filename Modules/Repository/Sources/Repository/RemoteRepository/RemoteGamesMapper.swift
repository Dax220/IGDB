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
            rating: ratingFormatter.roundRating(value: serverDTO.rating),
            genres: serverDTO.genres?.map(\.name)
        )
    }
}
