//
//  MockNetworkMonitor.swift
//  Repository
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import Core
import Combine

class MockNetworkMonitor: NetworkMonitorI, @unchecked Sendable {
    
    nonisolated(unsafe) static var isNetworkAvailable: Bool?
    
    var isConnectedPublisher: Published<Bool>.Publisher {
        $isConnectedValue
    }
    
    var isConnected: Bool {
        Self.isNetworkAvailable!
    }
    
    @Published
    private var isConnectedValue: Bool
    
    func startMonitoring() {}

    func stopMonitoring() {}
    
    init(isConnectedValue: Bool) {
        self.isConnectedValue = isConnectedValue
        Self.isNetworkAvailable = isConnectedValue
    }
}
