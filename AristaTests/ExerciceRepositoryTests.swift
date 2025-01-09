//
//  ExerciceRepositoryTests.swift
//  AristaTests
//
//  Created by Bruno Evrard on 29/12/2024.
//

import XCTest
import CoreData

final class ExerciceRepositoryTests: XCTestCase {
    
    
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        
        let objects = try! context.fetch(fetchRequest)
        
        
        
        for exercice in objects {
            
            context.delete(exercice)
            
        }
        
        
        
        try! context.save()
        
    }
    
    private func addExercice(context: NSManagedObjectContext, category: String, intensity: Int, startDate: Date, endDate: Date,  userFirstName: String, userLastName: String, password: String) {
        
        print("Current Context: \(context)")
        
        let newUser = User(context: context)
        
        newUser.firstName = userFirstName
        
        newUser.lastName = userLastName
        
        newUser.password = password
        
        try! context.save()
        
        
        
        let newExercise = Exercise(context: context)
        
        newExercise.type = category
        
        newExercise.intensity = Int16(intensity)
        
        newExercise.startDate = startDate
        
        newExercise.endDate = endDate
        
        newExercise.user = newUser
        
        try! context.save()
        
    }
    
    func test_WhenNoExerciseIsInDatabase_GetExercise_ReturnEmptyList() {
        
        // Clean manually all data
        
       //let persistenceController = PersistenceController(inMemory: true)
        let persistenceController = MockPersistenceController.shared
        print("Current Context: \(persistenceController.container.viewContext)")
       
        emptyEntities(context: persistenceController.container.viewContext)
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        
        let exercises = try! data.getExercise()
        
        XCTAssert(exercises.isEmpty == true)
    }
    
    func test_WhenAddingOneExerciseInDatabase_GetExercise_ReturnAListContainingTheExercise() {
        
        let persistenceController = MockPersistenceController.shared
        // Clean manually all data
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date = Date()
        let secondesAleatoires = Int.random(in: 3600...7200)
        let endDate = date.addingTimeInterval(TimeInterval(secondesAleatoires))
        
        print("Current Context: \(persistenceController.container.viewContext)")
        addExercice(context: persistenceController.container.viewContext, category: "Football", intensity: 5, startDate: date, endDate: endDate, userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        
        let exercises = try! data.getExercise()
        
        
        
        XCTAssert(exercises.isEmpty == false)
        
        XCTAssert(exercises.first?.type == "Football")
        
        XCTAssert(exercises.first?.intensity == 5)
        
        XCTAssert(exercises.first?.startDate == date)
        
        XCTAssert(exercises.first?.endDate == endDate)
        
    }
    
    func test_WhenAddingMultipleExerciseInDatabase_GetExercise_ReturnAListContainingTheExerciseInTheRightOrder() {
        
        let persistenceController = MockPersistenceController.shared
        // Clean manually all data
        
        let entities = persistenceController.container.managedObjectModel.entities
            print("Entities: \(entities.map { $0.name ?? "Unnamed" })")
            
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date1 = Date()
        
        let date2 = Date(timeIntervalSinceNow: -(60*60*24))
        
        let date3 = Date(timeIntervalSinceNow: -(60*60*24*2))
        
        
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "Football",
                    
                    intensity: 5,
                    
                    startDate: date1,
                    
                    endDate: addRandomTime(to: date1),
                    
                    userFirstName: "Erica",
                    
                    userLastName: "Marcusi",
        
                    password: "motdepasseLong")
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "Running",
                    
                    intensity: 1,
                    
                    startDate: date3,
                    
                    endDate: addRandomTime(to: date3),
                    
                    userFirstName: "Erice",
                    
                    userLastName: "Marceau",
                    
                    password: "motdepasseLong")
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "Fitness",
                    
                    intensity: 5,
                    
                    startDate: date2,
                    
                    endDate: addRandomTime(to: date2),
                    
                    userFirstName: "Frédericd",
                    
                    userLastName: "Marcus",
                    
                    password: "motdepasseLong")
        
        
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        
        let exercises = try! data.getExercise()
        
        
        
        XCTAssert(exercises.count == 3)
        
        XCTAssert(exercises[0].type == "Football")
        
        XCTAssert(exercises[1].type == "Fitness")
        
        XCTAssert(exercises[2].type == "Running")
        
    }
    
    func test_AddExercise() {
        let persistenceController = MockPersistenceController.shared
        
        let entities = persistenceController.container.managedObjectModel.entities
            print("Entities: \(entities.map { $0.name ?? "Unnamed" })")
        emptyEntities(context: persistenceController.container.viewContext)
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        let startDate = Date()
        let endDate = addRandomTime(to: startDate)
        
        let exercideModel = ExerciseModel(type: ExerciseType.cyclisme, intensity: 10.0, startDate: startDate, endDate: endDate)
        
        do {
            try data.addExercise(model: exercideModel)
            
            let exercises = try! data.getExercise()
            
            XCTAssert(exercises.isEmpty == false)
            
            XCTAssert(exercises.first?.type == ExerciseType.cyclisme.rawValue)
            
            XCTAssert(exercises.first?.intensity == 10)
            
            XCTAssert(exercises.first?.startDate == startDate)
            
            XCTAssert(exercises.first?.endDate == endDate)
        }
        catch {
           
        }
        
    }
    
    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: 3600...7200)
        return to.addingTimeInterval(TimeInterval(seconds))
    }
    
}
