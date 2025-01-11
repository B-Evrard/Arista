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
