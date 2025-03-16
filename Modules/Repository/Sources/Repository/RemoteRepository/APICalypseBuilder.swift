//
//  APICalypseBuilder.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

class APICalypseBuilder {
    
    func buildApiCalypseForGames(parameters: FetchGamesParameters) -> APICalypse {
        var apicalypse = APICalypse()
        if let fields = parameters.fields {
            apicalypse = apicalypse.fields(fields: fields.map(\.rawValue).joined(separator: ","))
        }
        return apicalypse
    }
    
    func buildApiCalypseForPrimitives(parameters: FetchGamesParameters) -> APICalypse {
        var apicalypse = APICalypse()
        apicalypse = apicalypse.fields(fields: "game_id")
        if let limit = parameters.limit {
            apicalypse = apicalypse.limit(value: Int32(limit))
        }
        if let offset = parameters.offset {
            apicalypse = apicalypse.offset(value: Int32(offset))
        }
        apicalypse = apicalypse.where(query: "popularity_type = 3")
        apicalypse = apicalypse.sort(field: "value", order: .DESCENDING)
        return apicalypse
    }
}
