//
//  UserRepository.swift
//  Arista
//
//  Created by Bruno Evrard on 18/12/2024.
//

import Foundation
import CoreData

struct UserRepository {
    
    enum _Error: Error {
        case userNotFound
    }
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
       self.viewContext = viewContext
    }
    
    func getUser() throws -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.fetchLimit = 1
        
        let user = try viewContext.fetch(request).first
        
        if let user {
            return user
        }
        else {
            throw _Error.userNotFound
        }
    }
    
    
}

