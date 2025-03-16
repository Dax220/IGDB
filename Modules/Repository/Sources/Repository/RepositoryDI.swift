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
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(PersistenceController.self) { _ in
            PersistenceController()
        }
        .inObjectScope(.container)
        
        container.register(AsyncIGDBWrapperI.self) { _ in
            let wrapper = IGDBWrapper(
                clientID: "zzs4gfiji5brwwulue73l8ug1vjbhr", 
                accessToken: "y91urcv3rtjwpgk685on6s4h29mlkn"
            )
            return AsyncIGDBWrapper(wrapper: wrapper)
        }
        
        container.register(RemoteRepositoryI.self) { r in
            let asyncWrapper = r.resolve(AsyncIGDBWrapperI.self)!
            let ratingFormatter = RatingFormatter()
            let mapper = RemoteGamesMapper(ratingFormatter: ratingFormatter)
            let apiCalypseBuilder = APICalypseBuilder()
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
            let networkMonitor = r.resolve(NetworkMonitorI.self)!
            return RepositoryFacade(
                remoteRepository: remoteRepository,
                localRepository: localRepository,
                networkMonitor: networkMonitor
            )
        }.inObjectScope(.container)
    }
}
