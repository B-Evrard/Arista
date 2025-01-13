//
//  Persistence.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import CoreData

class PersistenceController {
    
    static var shared = PersistenceController()
    static func resetShared(inMemory: Bool = false) {
        shared = PersistenceController(inMemory: inMemory)
    }
    let container: NSPersistentContainer
   

    static var preview: PersistenceController = {
        do {
            let result = PersistenceController(inMemory: true)
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

    
    init(inMemory: Bool = false) {
        
        guard let modelURL = Bundle.main.url(forResource: "Arista", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: PersistenceController.self)]) else {
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
        
        if (!inMemory) {
            try! DefaultData(viewContext: container.viewContext).apply()
        }
    }
}
