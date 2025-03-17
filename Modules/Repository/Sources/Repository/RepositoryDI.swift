//
//  File.swift
//  Repository
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Swinject
import IGDB_SWIFT_API
import Core

public class RepositoryDI: Assembly {
    
    private let clientID: String
    private let accessToken: String
    private let popularityType: String
    
    public init(
        clientID: String,
        accessToken: String,
        popularityType: String
    ) {
        self.clientID = clientID
        self.accessToken = accessToken
        self.popularityType = popularityType
    }
    
    public func assemble(container: Container) {
        
        container.register(PersistenceController.self) { _ in
            PersistenceController()
        }
        .inObjectScope(.container)
        
        container.register(AsyncIGDBWrapperI.self) { _ in
            let wrapper = IGDBWrapper(
                clientID: self.clientID,
                accessToken: self.accessToken
            )
            return AsyncIGDBWrapper(wrapper: wrapper)
        }
        
        container.register(RemoteRepositoryI.self) { r in
            let asyncWrapper = r.resolve(AsyncIGDBWrapperI.self)!
            let ratingFormatter = RatingFormatter()
            let mapper = RemoteGamesMapper(ratingFormatter: ratingFormatter)
            let apiCalypseBuilder = APICalypseBuilder(popularityType: self.popularityType)
            return RemoteRepository(
                apiCalypseBuilder: apiCalypseBuilder,
                wrapper: asyncWrapper, mapper: mapper
            )
        }
        
        container.register(LocalRepositoryI.self) { r in
            let mapper = LocalGamesMapper()
            let moc = r.resolve(PersistenceController.self)!.container.viewContext
            return LocalRepository(moc: moc, mapper: mapper)
        }
        
        container.register(RepositoryFacadeI.self) { r in
            let remoteRepository = r.resolve(RemoteRepositoryI.self)!
            let localRepository = r.resolve(LocalRepositoryI.self)!
            return RepositoryFacade(
                remoteRepository: remoteRepository,
                localRepository: localRepository
            )
        }.inObjectScope(.container)
    }
}
