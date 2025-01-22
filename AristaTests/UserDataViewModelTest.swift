//
//  UserDataViewModelTest.swift
//  AristaTests
//
//  Created by Bruno Evrard on 14/01/2025.
//

import XCTest
import CoreData
import Combine

final class UserDataViewModelTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    func test_init() {
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        addUser(context: persistenceController.container.viewContext, userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")
        
        let viewModel = UserDataViewModel()
        let expectation = XCTestExpectation(description: "fetch list of sleep")
        
        let fullName = "Eric Marcus"
        viewModel.$userModel
        
            .sink { userModel in
                XCTAssert(userModel?.firstName == "Eric")
                XCTAssert(userModel?.lastName == "Marcus")
                XCTAssert(userModel?.password == "motdepasseLong")
                XCTAssert(viewModel.fullName == fullName)
                expectation.fulfill()
            }
        
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
    }
   
    
    private func addUser(context: NSManagedObjectContext, userFirstName: String, userLastName: String, password: String) {
        
        let newUser = User(context: context)
        newUser.firstName = userFirstName
        newUser.lastName = userLastName
        newUser.password = password
        try! context.save()
        
    }
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
 
        for user in objects {
            context.delete(user)
        }
        try! context.save()
    }

}
