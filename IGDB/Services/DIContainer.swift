//
//  DIContainer.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Repository
import Swinject

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
        RepositoryDI().assemble(container: container)
    }
}
