//
//  SleepRepositoryTest.swift
//  AristaTests
//
//  Created by Bruno Evrard on 10/01/2025.
//

import XCTest
import CoreData

final class SleepRepositoryTest: XCTestCase {

    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: (6*60*60)...(8*60*60))
        return to.addingTimeInterval(TimeInterval(seconds))
    }
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Sleep.fetchRequest()
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
    
    func test_WhenNoSleep() {
        
        let persistenceController = PersistenceController.init(inMemory: true)
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let data = SleepRepository(viewContext: persistenceController.container.viewContext)
        
        let sleeps = try! data.getSleepSessions()
        
        XCTAssert(sleeps.isEmpty == true)
    }
    
    func test_WhenAddingOneSleep() {
        
        let persistenceController = PersistenceController.init(inMemory: true)
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date = Date()
        let endDate = addRandomTime(to: date)
        
        addSleep(context: persistenceController.container.viewContext, quality: 10, startDate: date, endDate: endDate, userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        let data = SleepRepository(viewContext: persistenceController.container.viewContext)
        
        let sleepSessions = try! data.getSleepSessions()
        
        
        
        XCTAssert(sleepSessions.isEmpty == false)
        
        XCTAssert(sleepSessions.first?.quality == 10)
        
        XCTAssert(sleepSessions.first?.startDate == date)
        
        XCTAssert(sleepSessions.first?.endDate == endDate)
        
    }
    
    func test_WhenAddingMultipleSleep_GetExercise_ReturnAListInTheRightOrder() {
        
        let persistenceController = PersistenceController.init(inMemory: true)
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
        
        let data = SleepRepository(viewContext: persistenceController.container.viewContext)
        let sleepSessions = try! data.getSleepSessions()
        
        XCTAssert(sleepSessions.count == 3)
        
        XCTAssert(sleepSessions[0].startDate == date1)
        
        XCTAssert(sleepSessions[1].startDate == date2)
        
        XCTAssert(sleepSessions[2].startDate == date3)
        
    }
}
 
