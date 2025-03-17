//
//  DIContainer.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Repository
import Swinject
import Core

class DIContainer {
    
    static let shared: DIContainer = .init()
    
    private let container = Container()
    
    init() {
        register()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        return container.synchronize().resolve(type)!
    }
    
    func register() {
        CoreDI().assemble(container: container)
        RepositoryDI(
            clientID: ENV.value(for: .apiClientId),
            accessToken: ENV.value(for: .apiAccessToken),
            popularityType: ENV.value(for: .popularityType)
        ).assemble(container: container)
    }
}
