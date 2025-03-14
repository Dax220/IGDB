//
//  RemoteRepository.swift
//  Repository
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import Foundation
import Domain
import IGDB_SWIFT_API

class RemoteRepository: RemoteRepositoryI {
    
    private let apiCalypseBuilder: APICalypseBuilder
    private let wrapper: AsyncIGDBWrapperI
    private let mapper: RemoteGamesMapper
    
    init(apiCalypseBuilder: APICalypseBuilder, wrapper: AsyncIGDBWrapperI, mapper: RemoteGamesMapper) {
        self.apiCalypseBuilder = apiCalypseBuilder
        self.wrapper = wrapper
        self.mapper = mapper
    }
    
    func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        let apiCalypse = apiCalypseBuilder.buildApiCalypse(parameters: parameters)
        print(apiCalypse.buildQuery())
        let gamesJson = try await wrapper.jsonGames(apiCalypse: apiCalypse)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = gamesJson.data(using: .utf8) else {
            throw AppError.invalidUTF8(gamesJson)
        }
        let serverDTO = try decoder.decode([GameServerDTO].self, from: data)
        return serverDTO.map(mapper.mapFromServerDTO)
    }
}
