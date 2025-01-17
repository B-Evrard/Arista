//
//  AddExerciseViewModelTest.swift
//  AristaTests
//
//  Created by Bruno Evrard on 16/01/2025.
//

import XCTest
import CoreData

final class AddExerciseViewModelTest: XCTestCase {

    func testAddExercise() {
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = AddExerciseViewModel()
        
        let startDate = Date()
        let endDate = addRandomTime(to: startDate)
        viewModel.exercise.type = ExerciseType.cyclisme
        viewModel.exercise.intensity = 10
        viewModel.exercise.startDate = startDate
        viewModel.exercise.endDate = endDate
        
        if (viewModel.addExercise()) {
            let data = ExerciseRepository()
            let exercises = try! data.getExercise()
            XCTAssert(exercises.count == 1)
            XCTAssert(exercises.first?.type == ExerciseType.cyclisme.rawValue)
            XCTAssert(exercises.first?.intensity == 10)
            XCTAssert(exercises.first?.startDate == startDate)
            XCTAssert(exercises.first?.endDate == endDate)
        }
        else {
            XCTAssertTrue(viewModel.showAlert)
        }
    }
    
    
    func testAddInvalidExercise() {
        PersistenceController.resetShared(inMemory: true)
        let persistenceController = PersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = AddExerciseViewModel()
        
        let startDate = Date()
        
        viewModel.exercise.type = ExerciseType.unknown
        viewModel.exercise.intensity = 10
        viewModel.exercise.startDate = startDate
        viewModel.exercise.endDate = startDate
        
        XCTAssertFalse(viewModel.addExercise())
        XCTAssertTrue(viewModel.showAlert)
        XCTAssert(viewModel.messageAlert == "Selectionnez la catégorie")
        
        viewModel.exercise.type = ExerciseType.cyclisme
        XCTAssertFalse(viewModel.addExercise())
        XCTAssertTrue(viewModel.showAlert)
        XCTAssert(viewModel.messageAlert == "Date de début et fin incohérente")
        
        
    }
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        for exercice in objects {
            
            context.delete(exercice)
            
        }
        try! context.save()
        
    }
    
    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: 3600...7200)
        return to.addingTimeInterval(TimeInterval(seconds))
    }
}
