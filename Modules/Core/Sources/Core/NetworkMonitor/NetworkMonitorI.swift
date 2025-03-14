//
//  NetworkMonitorManager.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Combine

public protocol NetworkMonitorI {
    
    var isConnectedPublisher: Published<Bool>.Publisher { get }
    var isConnected: Bool { get }
    
    func startMonitoring() async
    func stopMonitoring() async
}
