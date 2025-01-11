//
//  Persistence.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import CoreData

class PersistenceController {
    
    static let shared = try? PersistenceController()
    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        do {
            let result = try PersistenceController(inMemory: true)
            let viewContext = result.container.viewContext
        
            try viewContext.save()
            return result
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }()

    
    init(inMemory: Bool = false) throws {
//        container = NSPersistentContainer(name: "Arista")
//        
//        if (inMemory) {
//            container.persistentStoreDescriptions.first?.type = NSInMemoryStoreType
//        }
//        
//        
//        var loadError: Error?
//        container.loadPersistentStores { (storeDescription, error) in
//            if let error = error as NSError? {
//                loadError = error
//            }
//        }
//        
//        if let error = loadError {
//            throw error
//        }
//        
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        
//        if (!inMemory) {
//            try DefaultData(viewContext: container.viewContext).apply()
//        }
        
        let bundle = Bundle(for: type(of: self))
        guard let modelURL = bundle.url(forResource: "Arista", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load Core Data model")
        }

        container = NSPersistentContainer(name: "Arista", managedObjectModel: managedObjectModel)
        if (inMemory) {
            container.persistentStoreDescriptions.first?.type = NSInMemoryStoreType
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
