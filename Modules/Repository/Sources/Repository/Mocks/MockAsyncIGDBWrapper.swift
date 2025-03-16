//
//  MockAsyncIGDBWrapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation
import IGDB_SWIFT_API

class MockAsyncIGDBWrapper: AsyncIGDBWrapperI {
    func jsonGames(apiCalypse: APICalypse) async throws -> String {
        
        let bundle = Bundle.myPackage
        
        guard let url = bundle.url(forResource: "GamesMockResponse", withExtension: "json") else {
            fatalError("Failed to locate GamesMockResponse.json file")
        }
        
        do {
            let jsonString = try String(contentsOf: url, encoding: .utf8)
            return jsonString
        } catch {
            fatalError("Failed to read GamesMockResponse.json file")
        }
    }
}
