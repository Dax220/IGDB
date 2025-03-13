//
//  GamesParameters.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

public struct FetchGamesParameters {
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

public struct GameSorting {
    let gameField: GameFields
    let order: SortOrder
    
    public init(gameField: GameFields, order: SortOrder) {
        self.gameField = gameField
        self.order = order
    }
}

public enum SortOrder: String {
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

public enum GameFields: String, CaseIterable {
    case name
    case coverImageId = "cover.image_id"
    case rating
    case genresName = "genres.name"
}
