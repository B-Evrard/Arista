import XCTest

import CoreData

import Combine

@testable import Arista

final class ExerciseListViewModelTests: XCTestCase {
    
    
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func test_WhenNoExerciseIsInDatabase_FetchExercise_ReturnEmptyList() {
        
        // Clean manually all data
        
        let persistenceController = MockPersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = ExerciseListViewModel(context: persistenceController.container.viewContext)
        
        let expectation = XCTestExpectation(description: "fetch empty list of exercise")
        
        
        
        viewModel.$exercises
        
            .sink { exercises in
                
                XCTAssert(exercises.isEmpty)
                
                expectation.fulfill()
                
            }
        
            .store(in: &cancellables)
        
        
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    
    func test_WhenAddingOneExerciseInDatabase_FEtchExercise_ReturnAListContainingTheExercise() {
        
        // Clean manually all data
        
        let persistenceController = MockPersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date = Date()
        let endDate = addRandomTime(to: date)
        
        addExercice(context: persistenceController.container.viewContext, category: "football", intensity: 5, startDate: date, endDate: endDate, userFirstName: "Eric", userLastName: "Marcus", password: "motdepasseLong")

        let viewModel = ExerciseListViewModel(context: persistenceController.container.viewContext)
        
        let expectation = XCTestExpectation(description: "fetch empty list of exercise")
        
        
        
        viewModel.$exercises
        
            .sink { exercises in
                
                XCTAssert(exercises.isEmpty == false)
                
                XCTAssert(exercises.first?.type == .football)
                
                XCTAssert(exercises.first?.endDate == endDate)
                
                XCTAssert(exercises.first?.intensity == 5)
                
                XCTAssert(exercises.first?.startDate == date)
                
                expectation.fulfill()
                
            }
        
            .store(in: &cancellables)
        
        
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    
    func test_WhenAddingMultipleExerciseInDatabase_FetchExercise_ReturnAListContainingTheExerciseInTheRightOrder() {
        
        // Clean manually all data
        
        let persistenceController = MockPersistenceController.shared
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date1 = Date()
        
        let date2 = Date(timeIntervalSinceNow: -(60*60*24))
        
        let date3 = Date(timeIntervalSinceNow: -(60*60*24*2))
        
        
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "football",
                    
                    intensity: 5,
                    
                    startDate: date1,
                    
                    endDate: addRandomTime(to: date1),
                    
                    userFirstName: "Erica",
                    
                    userLastName: "Marcusi",
        
                    password: "motdepasseLong")
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "running",
                    
                    intensity: 1,
                    
                    startDate: date3,
                    
                    endDate: addRandomTime(to: date3),
                    
                    userFirstName: "Erice",
                    
                    userLastName: "Marceau",
                    
                    password: "motdepasseLong")
        
        addExercice(context: persistenceController.container.viewContext,
                    
                    category: "natation",
                    
                    intensity: 5,
                    
                    startDate: date2,
                    
                    endDate: addRandomTime(to: date2),
                    
                    userFirstName: "Frédericd",
                    
                    userLastName: "Marcus",
                    
                    password: "motdepasseLong")
        
        
        
        let viewModel = ExerciseListViewModel(context: persistenceController.container.viewContext)
        
        let expectation = XCTestExpectation(description: "fetch empty list of exercise")
        
        
        
        viewModel.$exercises
        
            .sink { exercises in
                
                XCTAssert(exercises.count == 3)
                
                XCTAssert(exercises[0].type == .football)
                
                XCTAssert(exercises[1].type  == .natation)
                
                XCTAssert(exercises[2].type  == .running)
                
                expectation.fulfill()
                
            }
        
            .store(in: &cancellables)
        
        
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        
        let objects = try! context.fetch(fetchRequest)
        
        
        
        for exercice in objects {
            
            context.delete(exercice)
            
        }
        
        
        
        try! context.save()
        
    }
    
    private func addExercice(context: NSManagedObjectContext, category: String, intensity: Int, startDate: Date, endDate: Date,  userFirstName: String, userLastName: String, password: String) {
        
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
    
    private func addRandomTime(to: Date) -> Date {
        let seconds = Int.random(in: 3600...7200)
        return to.addingTimeInterval(TimeInterval(seconds))
    }
    
}
