//
//  GameServerDTO.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation

struct GameServerDTO: Decodable {
    let id: Int
    let cover: Cover
    let name: String
    let rating: Double
    let genres: [Genre]?
}

struct Cover: Decodable {
    let id: Int
    let imageId: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
