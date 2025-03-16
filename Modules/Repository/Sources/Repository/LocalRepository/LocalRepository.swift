//
//  File.swift
//  Repository
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import Domain
import CoreData

class LocalRepository {
    
    private let moc: NSManagedObjectContext
    private let mapper: LocalGamesMapper
    
    init(moc: NSManagedObjectContext, mapper: LocalGamesMapper) {
        self.moc = moc
        self.mapper = mapper
    }
}

extension LocalRepository: RepositoryI {
    
    func fetchGames(parameters: FetchGamesParameters) async throws -> [GameDTO] {
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        let games: [Game] = try fetch(
            sortDescriptor: sortDescriptor,
            limit: parameters.limit,
            offset: parameters.offset
        )
        
        return games.map({mapper.map(from: $0)})
    }
}

extension LocalRepository: LocalRepositoryI {
    
    func saveGames(_ games: [Domain.GameDTO]) async throws {
        try await createCoreDataGame(gameDTOs: games)
    }
    
    func deleteAllGames() async throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        if let result = try moc.execute(deleteRequest) as? NSBatchDeleteResult,
           let objectIDs = result.result as? [NSManagedObjectID] {
            let changes = [NSDeletedObjectsKey: objectIDs]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [moc])
        }
    }
}

extension LocalRepository {
    
    private func createCoreDataGame(gameDTOs: [GameDTO]) async throws {
        return try await moc.perform {
            for gameDTO in gameDTOs {
                let game = Game(context: self.moc)
                game.id = Int32(gameDTO.id)
                game.name = gameDTO.name
                game.rating = gameDTO.rating
                if let ratingCount = gameDTO.ratingCount {
                    game.ratingCount = Int32(ratingCount)
                }
                game.aggregatedRating = gameDTO.aggregatedRating
                if let aggregatedRatingCount = gameDTO.aggregatedRatingCount {
                    game.aggregatedRatingCount = Int32(aggregatedRatingCount)
                }
                game.coverImageURL = gameDTO.coverImageURL
                game.genres = NSArray(array: gameDTO.genres ?? [])
                game.platforms = NSArray(array: gameDTO.platforms ?? [])
                game.summary = gameDTO.summary
                game.mainDevelopers = NSArray(array: gameDTO.mainDevelopers ?? [])
                game.portingDevelopers = NSArray(array: gameDTO.portingDevelopers ?? [])
                game.supportingDevelopers = NSArray(array: gameDTO.supportingDevelopers ?? [])
                game.publishers = NSArray(array: gameDTO.publishers ?? [])
                game.themes = NSArray(array: gameDTO.themes ?? [])
                game.gameModes = NSArray(array: gameDTO.gameModes ?? [])
                game.playerPerspectives = NSArray(array: gameDTO.playerPerspectives ?? [])
                game.storyline = gameDTO.storyline
                for videoDTO in gameDTO.videos ?? [] {
                    game.videos?.adding(self.createVideosForGame(game: game, videoDTO: videoDTO))
                }
                game.screenshots = NSArray(array: gameDTO.screenshots ?? [])
                game.createdAt = Date()
            }
            try self.saveContext()
        }
    }
    
    private func createVideosForGame(game: Game, videoDTO: VideoDTO) -> Video {
        let video = Video(context: self.moc)
        video.game = game
        video.title = videoDTO.title
        video.videoId = videoDTO.youtubeId
        return video
    }
    
    private func fetch<T: NSManagedObject>(
        predicate: NSPredicate? = nil,
        sortDescriptor: NSSortDescriptor? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) throws -> [T] {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            fatalError("Invalid fetch request type for \(T.self)")
        }
        if let sortDescriptor = sortDescriptor {
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        if let offset = offset {
            fetchRequest.fetchOffset = offset
        }
        fetchRequest.predicate = predicate
        return try moc.fetch(fetchRequest)
    }
    
    private func saveContext() throws {
        do {
            if moc.hasChanges {
                try moc.save()
            }
        } catch let error {
            print("SAVE MOC ERROR: \(error)")
            throw error
        }
    }
}


