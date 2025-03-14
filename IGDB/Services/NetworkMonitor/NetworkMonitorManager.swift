//
//  NetworkMonitorManager.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//


protocol NetworkMonitorManager {
    func startMonitoring() async
    func stopMonitoring() async
}
