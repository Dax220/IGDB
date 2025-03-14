//
//  NetworkMonitor.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//


import Network
import Combine

class NetworkMonitor: NetworkMonitorI, @unchecked Sendable {
    
    var isConnectedPublisher: Published<Bool>.Publisher {
        $isConnectedValue
    }
    
    var isConnected: Bool {
        isConnectedValue
    }
    
    @Published
    private var isConnectedValue: Bool = false
    
    private let queue = DispatchQueue.global()
    private let monitor = NWPathMonitor()
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnectedValue = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
