//
//  NetworkMonitorConnectionStatus.swift
//  IGDB
//
//  Created by Maxim Tischenko on 14.03.2025.
//

import Combine

protocol NetworkMonitorConnectionStatus {
    var isConnectedPublisher: Published<Bool>.Publisher { get }
}
