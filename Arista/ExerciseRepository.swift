//
//  ExerciseRepository.swift
//  Arista
//
//  Created by Bruno Evrard on 18/12/2024.
//

import Foundation
import CoreData

struct ExerciseRepository {
    
    let viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
        
        
    func getExercise() throws -> [ExerciseModel] {
        let request = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Exercise>(\.startDate, order: .reverse))]
        return try viewContext.fetch (request).map { toModel($0) }
    }
   
   
    func addExercise(exercise: ExerciseModel) throws {
        _ = toEntity(exercise)
        try viewContext.save()
    }
    
    func deleteAllExercises() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try viewContext.execute(batchDeleteRequest)
    }
    
    func toModel(_ exercise: Exercise) -> ExerciseModel {
        return ExerciseModel(
            type: ExerciseType(rawValue: exercise.type ?? "") ,
            intensity: Int(exercise.intensity),
            startDate: exercise.startDate ?? Date(),
            endDate: exercise.endDate ?? Date()
        )
    }
    
    func toEntity(_ model: ExerciseModel) -> Exercise {
        let exercise = Exercise(context: viewContext)
        exercise.type = model.type.rawValue
        exercise.intensity = Int16(model.intensity)
        exercise.startDate = model.startDate
        exercise.endDate = model.endDate
        return exercise
    }
}

