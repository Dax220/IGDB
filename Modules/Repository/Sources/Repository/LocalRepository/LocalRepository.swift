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
            for (idx, gameDTO) in gameDTOs.enumerated() {
                let game = Game(context: self.moc)
                game.id = Int32(gameDTO.id)
                game.name = gameDTO.name
                game.rating = gameDTO.rating
                game.coverImageURL = gameDTO.coverImageURL
                game.genres = gameDTO.genres
                game.createdAt = Date()
            }
            try self.saveContext()
        }
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

class LocalGamesMapper {
    
    func map(from game: Game) -> GameDTO {
        GameDTO(
            id: Int(game.id),
            coverImageURL: game.coverImageURL,
            name: game.name ?? "",
            rating: game.rating ?? "",
            genres: game.genres
        )
    }
}
