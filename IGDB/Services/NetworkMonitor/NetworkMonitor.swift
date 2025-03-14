//
//  NetworkMonitor.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//


import Network
import Combine

class NetworkMonitor: NetworkMonitorConnectionStatus, NetworkMonitorManager {
    
    var isConnectedPublisher: Published<Bool>.Publisher {
        $isConnected
    }
        
    @Published
    private var isConnected: Bool = false
    
    private let queue = DispatchQueue.global()
    private let monitor = NWPathMonitor()
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
