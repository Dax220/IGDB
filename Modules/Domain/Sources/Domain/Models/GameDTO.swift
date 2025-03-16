//
//  File.swift
//  Domain
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import Foundation

public struct GameDTO: Sendable, Identifiable, Equatable, Hashable {
    public let id: Int
    public let coverImageURL: String?
    public let name: String
    public let rating: String
    public let ratingCount: Int?
    public let aggregatedRating: String?
    public let aggregatedRatingCount: Int?
    public let genres: [String]?
    public let platforms: [String]?
    public let summary: String?
    public let mainDevelopers: [String]?
    public let portingDevelopers: [String]?
    public let supportingDevelopers: [String]?
    public let publishers: [String]?
    public let themes: [String]?
    public let gameModes: [String]?
    public let playerPerspectives: [String]?
    public let storyline: String?
    public let videos: [VideoDTO]?
    public let screenshots: [String]?
    
    public init(
        id: Int,
        coverImageURL: String?,
        name: String,
        rating: String,
        ratingCount: Int?,
        aggregatedRating: String?,
        aggregatedRatingCount: Int?,
        genres: [String]?,
        platforms: [String]?,
        summary: String?,
        mainDevelopers: [String]?,
        portingDevelopers: [String]?,
        supportingDevelopers: [String]?,
        publishers: [String]?,
        themes: [String]?,
        gameModes: [String]?,
        playerPerspectives: [String]?,
        storyline: String?,
        videos: [VideoDTO]?,
        screenshots: [String]?
    ) {
        self.id = id
        self.coverImageURL = coverImageURL
        self.name = name
        self.rating = rating
        self.ratingCount = ratingCount
        self.aggregatedRating = aggregatedRating
        self.aggregatedRatingCount = aggregatedRatingCount
        self.genres = genres
        self.platforms = platforms
        self.summary = summary
        self.mainDevelopers = mainDevelopers
        self.portingDevelopers = portingDevelopers
        self.supportingDevelopers = supportingDevelopers
        self.publishers = publishers
        self.themes = themes
        self.gameModes = gameModes
        self.playerPerspectives = playerPerspectives
        self.storyline = storyline
        self.videos = videos
        self.screenshots = screenshots
    }
}

public struct VideoDTO: Sendable, Equatable, Hashable {
    public var youtubeId: String
    public var title: String?
    
    public init(youtubeId: String, title: String?) {
        self.youtubeId = youtubeId
        self.title = title
    }
}

public extension GameDTO {
    static let dummy = GameDTO(
        id: 1,
        coverImageURL: "123",
        name: "The witcher 3: Wild Hunt",
        rating: "9.2",
        ratingCount: 123,
        aggregatedRating: "9.2",
        aggregatedRatingCount: 456,
        genres: ["Role-playing (RPG)"],
        platforms: ["PC (Microsoft Windows)"],
        summary: "RPG and sequel to The Witcher 2 (2011), The Witcher 3 follows witcher Geralt of Rivia as he seeks out his former lover and his young subject while intermingling with the political workings of the wartorn Northern Kingdoms. Geralt has to fight monsters and deal with people of all sorts in order to solve complex problems and settle contentious disputes, each ranging from the personal to the world-changing.",
        mainDevelopers: ["CD Projekt Red"],
        portingDevelopers: ["Saber Interactive"],
        supportingDevelopers: ["D3T Limited"],
        publishers: ["Bandai Namco Entertainment"],
        themes: ["Action"],
        gameModes: ["Single player"],
        playerPerspectives: ["Third person"],
        storyline: "The Witcher 3: Wild Hunt concludes the story of the witcher Geralt of Rivia, the series' protagonist, whose story to date has been covered in the previous installments. Geralt's new mission comes in dark times as the mysterious and otherworldly army known as the Wild Hunt invades the Northern Kingdoms, leaving only blood soaked earth and fiery ruin in its wake; and it seems the Witcher is the key to stopping their cataclysmic rampage.",
        videos: [],
        screenshots: []
    )
}
