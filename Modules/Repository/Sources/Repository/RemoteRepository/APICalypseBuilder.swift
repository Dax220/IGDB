//
//  APICalypseBuilder.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

class APICalypseBuilder {
    
    func buildApiCalypse(parameters: FetchGamesParameters) -> APICalypse {
        var apicalypse = APICalypse()
        if let fields = parameters.fields {
            apicalypse = apicalypse.fields(fields: fields.map(\.rawValue).joined(separator: ","))
        }
        if let sorting = parameters.sorting {
            apicalypse = apicalypse.sort(field: sorting.gameField.rawValue, order: sorting.order.sort)
        }
        if let limit = parameters.limit {
            apicalypse = apicalypse.limit(value: Int32(limit))
        }
        if let offset = parameters.offset {
            apicalypse = apicalypse.offset(value: Int32(offset))
        }
        return apicalypse
    }
}
