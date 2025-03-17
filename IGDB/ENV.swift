//
//  ENV.swift
//  IGDB
//
//  Created by Maxim Tischenko on 17.03.2025.
//

import Foundation

struct ENV {

    enum Key: String {
        case popularityType = "PopularityType"
        case apiClientId = "ApiClientId"
        case apiAccessToken = "ApiAccessToken"
    }
    
    static func value<T>(for key: Key) -> T {
        guard let secretValue = infoDictionary[key.rawValue] as? T else {
            fatalError("\(key.rawValue) not set in Info plist")
        }
        return secretValue
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info plist file not found")
        }
        print("dict: \(dict)")
        return dict
    }()
}
