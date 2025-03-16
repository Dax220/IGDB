//
//  GamesParameters.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

public struct FetchGamesParameters: Sendable {
    let fields: [GameFields]?
    let sorting: GameSorting?
    let limit: Int?
    let offset: Int?
    
    public init(
        fields: [GameFields]? = nil,
        sorting: GameSorting? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) {
        self.fields = fields
        self.sorting = sorting
        self.limit = limit
        self.offset = offset
    }
}

public struct GameSorting: Sendable {
    let gameField: GameFields
    let order: SortOrder
    
    public init(gameField: GameFields, order: SortOrder) {
        self.gameField = gameField
        self.order = order
    }
}

public enum SortOrder: String, Sendable {
    case asc
    case desc
    
    var sort: Sort {
        switch self {
        case .asc:
            return .ASCENDING
        case .desc:
            return .DESCENDING
        }
    }
}
 
public enum GameFields: String, CaseIterable, Sendable {
    case name
    case coverImageId = "cover.image_id"
    case rating
    case ratingCount = "rating_count"
    case genresName = "genres.name"
    case platforms = "platforms.name"
    case aggregatedRating = "aggregated_rating"
    case aggregatedRatingCount = "aggregated_rating_count"
    case summary
    case involvedCompaniesName = "involved_companies.company.name"
    case involvedCompaniesDeveloper = "involved_companies.developer"
    case involvedCompaniesPublisher = "involved_companies.publisher"
    case involvedCompaniesPorting = "involved_companies.porting"
    case involvedCompaniesSupporting = "involved_companies.supporting"
    case themes = "themes.name"
    case gameModes = "game_modes.name"
    case playerPerspectives = "player_perspectives.name"
    case storyline
    case videoName = "videos.name"
    case videoId = "videos.video_id"
    case screenShotImageId = "screenshots.image_id"
}
