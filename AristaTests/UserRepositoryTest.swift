
//
//  UserRepositoryTest.swift.swift
//  AristaTests
//
//  Created by Bruno Evrard on 10/01/2025.
//

import XCTest
import CoreData

final class UserRepositoryTest: XCTestCase {

    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: (6*60*60)...(8*60*60))
        return to.addingTimeInterval(TimeInterval(seconds))
    }
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = User.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        for user in objects {
            context.delete(user)
        }
        try! context.save()
        
    }
    
    private func addUser(context: NSManagedObjectContext, userFirstName: String, userLastName: String, password: String) {
        
        let newUser = User(context: context)
        newUser.firstName = userFirstName
        newUser.lastName = userLastName
        newUser.password = password
        try! context.save()
        
    }
    
    func test_WhenNoUser() {
        
        let persistenceController = MockPersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let data = UserRepository(viewContext: persistenceController.container.viewContext)
        
        let user = try? data.getUser()
        
        XCTAssertNil(user)
    }
    
    func test_WhenAddingOneUser() {
        
        let persistenceController = MockPersistenceController.shared
        emptyEntities(context: persistenceController.container.viewContext)
        
        addUser(context: persistenceController.container.viewContext, userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        let data = UserRepository(viewContext: persistenceController.container.viewContext)
        
        let user = try! data.getUser()
        
        XCTAssert(user.firstName == "Eric")
        
        XCTAssert(user.lastName == "Marcus")
        
        XCTAssert(user.password == "motdepasseLong")
        
    }
    
    
}
 
