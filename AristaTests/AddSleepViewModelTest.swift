//
//  AddSleepViewModelTest.swift
//  Arista
//
//  Created by Bruno Evrard on 17/01/2025.
//

import XCTest
import CoreData

final class AddSleepViewModelTest: XCTestCase {

    func testAddExercise() {
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = AddSleepViewModel()
        
        let startDate = Date()
        let endDate = addRandomTime(to: startDate)
        viewModel.sleepModel.startDate = startDate
        viewModel.sleepModel.endDate = endDate
        viewModel.sleepModel.quality = 80
        
        
        if (viewModel.addSleep()) {
            let data = SleepRepository()
            let sleepSessions = try! data.getSleepSessions()
            XCTAssert(sleepSessions.count == 1)
            XCTAssert(sleepSessions.first?.startDate == startDate)
            XCTAssert(sleepSessions.first?.endDate == endDate)
            XCTAssert(sleepSessions.first?.quality == 80)
        }
        else {
            XCTAssertTrue(viewModel.showAlert)
        }
    }
    
    
    func testAddInvalidSleep() {
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = AddSleepViewModel()
        
        let startDate = Date()
        
        viewModel.sleepModel.startDate = startDate
        viewModel.sleepModel.endDate = startDate
        viewModel.sleepModel.quality = 80
        
        XCTAssertFalse(viewModel.addSleep())
        XCTAssertTrue(viewModel.showAlert)
        XCTAssert(viewModel.messageAlert == "Date de début et fin incohérente")
        
        
    }
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Sleep.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        for sleep in objects {
            
            context.delete(sleep)
            
        }
        try! context.save()
        
    }
    
    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: 3600...7200)
        return to.addingTimeInterval(TimeInterval(seconds))
    }
}
