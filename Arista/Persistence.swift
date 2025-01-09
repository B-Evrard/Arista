//
//  Persistence.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import CoreData

struct PersistenceController {
    static let shared = try? PersistenceController()

    let container: NSPersistentContainer

    init() throws {
        container = NSPersistentContainer(name: "Arista")
        
        var loadError: Error?
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                loadError = error
            }
        }
        
        if let error = loadError {
            throw error
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        try DefaultData(viewContext: container.viewContext).apply()
    }
}
