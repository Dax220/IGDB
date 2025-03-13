//
//  AsyncIGDBWrapper.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import IGDB_SWIFT_API

class AsyncIGDBWrapper: AsyncIGDBWrapperI {
    
    private let wrapper: IGDBWrapper
    
    public init(wrapper: IGDBWrapper) {
        self.wrapper = wrapper
    }
    
    func jsonGames(apiCalypse: APICalypse) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            wrapper.jsonGames(apiCalypse: apiCalypse, result: { json in
                continuation.resume(returning: json)
            }, errorResponse: { error in
                continuation.resume(throwing: error)
            })
        }
    }
}
