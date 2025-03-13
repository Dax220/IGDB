//
//  AsyncIGDBWrapperI.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

protocol AsyncIGDBWrapperI {
    func jsonGames(apiCalypse: APICalypse) async throws -> String
}
