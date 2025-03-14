//
//  RepositoryFactory.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation
import IGDB_SWIFT_API

public class RepositoryFactory {
    
    public init() {}
    
    public func makeRemoteRepository() -> Repository {
        let wrapper = IGDBWrapper(clientID: "zzs4gfiji5brwwulue73l8ug1vjbhr", accessToken: "y91urcv3rtjwpgk685on6s4h29mlkn")
        let asyncWrapper = AsyncIGDBWrapper(wrapper: wrapper)
        let ratingFormatter = RatingFormatter()
        let mapper = RemoteGamesMapper(ratingFormatter: ratingFormatter)
        let apiCalypseBuilder = APICalypseBuilder()
        return RemoteRepository(apiCalypseBuilder: apiCalypseBuilder, wrapper: asyncWrapper, mapper: mapper)
    }
}
