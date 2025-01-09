//
//  MockPersistenceController.swift
//  Arista
//
//  Created by Bruno Evrard on 08/01/2025.
//


//
//  Persistence.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import CoreData

class MockPersistenceController {
    
    static let shared = MockPersistenceController()

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()

    let container: NSPersistentContainer

    init() {
        let bundle = Bundle(for: type(of: self))
        guard let modelURL = bundle.url(forResource: "Arista", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to load Core Data model")
        }

        container = NSPersistentContainer(name: "Arista", managedObjectModel: managedObjectModel)
        container.persistentStoreDescriptions.first?.type = NSInMemoryStoreType
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}
