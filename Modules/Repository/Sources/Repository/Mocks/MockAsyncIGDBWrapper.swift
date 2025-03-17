//
//  MockAsyncIGDBWrapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation
import IGDB_SWIFT_API

enum MockResponse: String {
    case primitivesMockResponse = "PrimitivesMockResponse"
    case gamesMockResponse = "GamesMockResponse"
}

class MockAsyncIGDBWrapper: AsyncIGDBWrapperI {
    
    func jsonPopularPrimitives(apiCalypse: APICalypse) async throws -> String {
        try await json(mock: .primitivesMockResponse, apiCalypse: apiCalypse)
    }
    
    func jsonGames(apiCalypse: APICalypse) async throws -> String {
        try await json(mock: .gamesMockResponse, apiCalypse: apiCalypse)
    }
    
    private func json(mock: MockResponse, apiCalypse: APICalypse) async throws -> String {
        
        let bundle = Bundle.myPackage
        
        guard let url = bundle.url(forResource: mock.rawValue, withExtension: "json") else {
            fatalError("Failed to locate \(mock.rawValue).json file")
        }
        
        do {
            let jsonString = try String(contentsOf: url, encoding: .utf8)
            return jsonString
        } catch {
            fatalError("Failed to read \(mock.rawValue).json file")
        }
    }
}
