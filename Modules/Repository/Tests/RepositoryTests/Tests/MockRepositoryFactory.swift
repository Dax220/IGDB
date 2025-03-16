//
//  MockRepositoryFactory.swift
//  Repository
//
//  Created by Maxim Tischenko on 16.03.2025.
//

@testable import Repository
import Swinject
import Core

class MockRepositoryFactory {
    
    nonisolated(unsafe) static let shared = MockRepositoryFactory()
    
    let container = Container()
    
    init() {
        RepositoryDI().assemble(container: container)
        
        container.register(PersistenceController.self) { _ in
            PersistenceController(inMemory: true)
        }
        .inObjectScope(.container)
        
        container.register(NetworkMonitorI.self) { _ in
            MockNetworkMonitor(isConnectedValue: true)
        }
        .inObjectScope(.container)
     
        container.register(AsyncIGDBWrapperI.self) { _ in
            MockAsyncIGDBWrapper()
        }
        
        container.register(RepositoryFacadeI.self) { r in
            MockRepositoryFacade(
                remoteRepository: r.resolve(RemoteRepositoryI.self)!,
                localRepository: r.resolve(LocalRepositoryI.self)!,
                networkMonitor: r.resolve(NetworkMonitorI.self)!
            )
        }
        .inObjectScope(.container)
    }
  
    func makeRepository() -> RepositoryFacadeI {
        return container.resolve(RepositoryFacadeI.self)!
    }
}
