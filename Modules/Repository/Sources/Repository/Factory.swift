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
    
    public func makeRepositoryFacade() -> RepositoryFacadeI {
        let remoteRepository = makeRemoteRepository()
        let localRepository = makeLocalRepository()
        return RepositoryFacade(remoteRepository: remoteRepository, localRepository: localRepository)
    }
    
    private func makeRemoteRepository() -> RepositoryI {
        let wrapper = IGDBWrapper(clientID: "zzs4gfiji5brwwulue73l8ug1vjbhr", accessToken: "y91urcv3rtjwpgk685on6s4h29mlkn")
        let asyncWrapper = AsyncIGDBWrapper(wrapper: wrapper)
        let ratingFormatter = RatingFormatter()
        let mapper = RemoteGamesMapper(ratingFormatter: ratingFormatter)
        let apiCalypseBuilder = APICalypseBuilder()
        return RemoteRepository(apiCalypseBuilder: apiCalypseBuilder, wrapper: asyncWrapper, mapper: mapper)
    }
    
    private func makeLocalRepository() -> LocalRepositoryI {
        print("makeLocalRepository")
        let mapper = LocalGamesMapper()
        let moc = PersistenceController.shared.container.viewContext
        return LocalRepository(moc: moc, mapper: mapper)
    }
}
