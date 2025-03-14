//
//  File.swift
//  Core
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Swinject

public class CoreDI: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(NetworkMonitorI.self) { _ in
            let networkMonitor = NetworkMonitor()
            networkMonitor.startMonitoring()
            return networkMonitor
        }
        .inObjectScope(.container)
    }
}
