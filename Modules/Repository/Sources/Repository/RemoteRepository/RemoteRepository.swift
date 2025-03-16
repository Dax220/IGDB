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
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(apiCalypseBuilder: APICalypseBuilder, wrapper: AsyncIGDBWrapperI, mapper: RemoteGamesMapper) {
        self.apiCalypseBuilder = apiCalypseBuilder
        self.wrapper = wrapper
        self.mapper = mapper
    }
    
    func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        let gameIds = try await fetchPopularGameIds(parameters: parameters)
        var apiCalypse = apiCalypseBuilder.buildApiCalypseForGames(parameters: parameters)
        let joinedIds = gameIds.joined(separator: ",")
        apiCalypse = apiCalypse.where(query: "id = (\(joinedIds))")
        print(apiCalypse.buildQuery())
        let gamesJson = try await wrapper.jsonGames(apiCalypse: apiCalypse)
        guard let data = gamesJson.data(using: .utf8) else {
            throw AppError.invalidUTF8(gamesJson)
        }
        let serverDTO = try decoder.decode([GameServerDTO].self, from: data)
        return serverDTO.map(mapper.mapFromServerDTO)
    }
    
    private func fetchPopularGameIds(parameters: FetchGamesParameters) async throws -> [String] {
        let apiCalypse = apiCalypseBuilder.buildApiCalypseForPrimitives(parameters: parameters)
        print(apiCalypse.buildQuery()) 
        let primitivesJson = try await wrapper.jsonPopularPrimitives(apiCalypse: apiCalypse)
        guard let data = primitivesJson.data(using: .utf8) else {
            throw AppError.invalidUTF8(primitivesJson)
        }
        let primitivesServerDTO = try decoder.decode([PopularPremitiveServerDto].self, from: data)
        return primitivesServerDTO.map({String($0.gameId)})
    }
}
