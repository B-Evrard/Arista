//
//  SleepHistoryViewModelTest.swift
//  AristaTests
//
//  Created by Bruno Evrard on 14/01/2025.
//

import XCTest
import CoreData
import Combine

final class SleepHistoryViewModelTest: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    func test_fetchSleepSessions() {
        
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date1 = Date()
        let date2 = Date(timeIntervalSinceNow: -(60*60*24))
        let date3 = Date(timeIntervalSinceNow: -(60*60*24*2))
        
        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date1, endDate: addRandomTime(to: date1), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date3, endDate: addRandomTime(to: date3), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date2, endDate: addRandomTime(to: date2), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")
        
        
        let viewModel = SleepHistoryViewModel()
        let expectation = XCTestExpectation(description: "fetch list of sleep")
 
        viewModel.$sleepSessions
        
            .sink { sleepSessions in
                XCTAssert(sleepSessions.count == 3)
                expectation.fulfill()
            }
        
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_refresh() {
        
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date1 = Date()
        let date2 = Date(timeIntervalSinceNow: -(60*60*24))
        let date3 = Date(timeIntervalSinceNow: -(60*60*24*2))
        
        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date1, endDate: addRandomTime(to: date1), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date3, endDate: addRandomTime(to: date3), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")


        let viewModel = SleepHistoryViewModel()
        XCTAssert(viewModel.sleepSessions.count == 2)
        
        addSleep(context: persistenceController.container.viewContext, quality: 10,
                 startDate: date2, endDate: addRandomTime(to: date2), userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")
        
        viewModel.refreshSleepSessions()
        XCTAssert(viewModel.sleepSessions.count == 3)
        
    }

    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
 
        for sleep in objects {
            context.delete(sleep)
        }
        try! context.save()
    }
    
    private func addSleep(context: NSManagedObjectContext, quality: Int, startDate: Date, endDate: Date,  userFirstName: String, userLastName: String, password: String) {
        
        let newUser = User(context: context)
        newUser.firstName = userFirstName
        newUser.lastName = userLastName
        newUser.password = password
        try! context.save()
        
        let newSleep = Sleep(context: context)
        newSleep.startDate = startDate
        newSleep.endDate = endDate
        newSleep.quality = Int16(quality)
        try! context.save()
        
    }
    
    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: (6*60*60)...(8*60*60))
        return to.addingTimeInterval(TimeInterval(seconds))
    }
}
