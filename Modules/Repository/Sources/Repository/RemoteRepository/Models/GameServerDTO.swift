//
//  GameServerDTO.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation

struct GameServerDTO: Decodable {
    let id: Int
    let cover: CoverServerDTO?
    let name: String
    let rating: Double?
    let ratingCount: Int?
    let aggregatedRating: Double?
    let aggregatedRatingCount: Int?
    let genres: [GenreServerDTO]?
    let platforms: [PlatformServerDTO]?
    let summary: String?
    let involvedCompanies: [InvolvedCompanyServerDTO]?
    let themes: [ThemeServerDTO]?
    let gameModes: [GameModeServerDTO]?
    let playerPerspectives: [PlayerPerspectiveServerDTO]?
    let storyline: String?
    let videos: [VideoServerDTO]?
    let screenshots: [ScreenshotServerDTO]?
}

struct ScreenshotServerDTO: Decodable {
    let imageId: String
}

struct VideoServerDTO: Decodable {
    let videoId: String
    let name: String?
}

struct PlayerPerspectiveServerDTO: Decodable {
    let name: String
}

struct GameModeServerDTO: Decodable {
    let name: String
}

struct ThemeServerDTO: Decodable {
    let name: String
}

struct CoverServerDTO: Decodable {
    let imageId: String
}

struct GenreServerDTO: Decodable {
    let name: String
}

struct PlatformServerDTO: Decodable {
    let name: String
}

struct InvolvedCompanyServerDTO: Decodable {
    let company: CompanyServerDTO
    let developer: Bool
    let publisher: Bool
    let porting: Bool
    let supporting: Bool
}

struct CompanyServerDTO: Decodable {
    let name: String
}
