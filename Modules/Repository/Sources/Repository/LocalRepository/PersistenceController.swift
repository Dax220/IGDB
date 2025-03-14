//
//  Persistence.swift
//  IGDB
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import CoreData

final class PersistenceController: Sendable {
    
    public let container: NSPersistentContainer

    static let shared = PersistenceController()
    
    nonisolated(unsafe)
    private static let managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle.myPackage
        
        guard let url = bundle.url(forResource: "Model", withExtension: "momd") else {
            fatalError("Failed to locate momd file for xcdatamodeld")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file for xcdatamodeld")
        }
        
        return model
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model", managedObjectModel: Self.managedObjectModel)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
