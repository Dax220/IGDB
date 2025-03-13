//
//  File.swift
//  Domain
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import Foundation

public struct GameDTO: Sendable, Identifiable {
    public let id: Int
    public let coverImageURL: String?
    public let name: String
    public let rating: String
    public let genres: [String]?
    
    public init(
        id: Int,
        coverImageURL: String?,
        name: String,
        rating: String,
        genres: [String]?
    ) {
        self.id = id
        self.coverImageURL = coverImageURL
        self.name = name
        self.rating = rating
        self.genres = genres
    }
}
