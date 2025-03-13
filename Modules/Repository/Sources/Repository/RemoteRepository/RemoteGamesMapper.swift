//
//  RemoteGamesMapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Domain

class RemoteGamesMapper {
    
    private let ratingFormatter: RatingFormatter
    
    init(ratingFormatter: RatingFormatter) {
        self.ratingFormatter = ratingFormatter
    }
    
    func mapFromServerDTO(_ serverDTO: GameServerDTO) -> GameDTO {
        GameDTO(
            id: serverDTO.id,
            coverImageId: serverDTO.cover.imageId,
            name: serverDTO.name,
            rating: ratingFormatter.roundRating(value: serverDTO.rating),
            genres: serverDTO.genres?.map(\.name) ?? []
        )
    }
}
