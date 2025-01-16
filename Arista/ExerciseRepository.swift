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
        
        
    func getExercise() throws -> [Exercise] {
        let request = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Exercise>(\.startDate, order: .reverse))]
        return try viewContext.fetch (request).map { $0 }
    }
   
   
    func addExercise(type: String, intensity: Int16, startDate: Date, endDate: Date) throws {
        let exercise = Exercise(context: viewContext)
        exercise.type = type
        exercise.intensity = intensity
        exercise.startDate = startDate
        exercise.endDate = endDate
        try viewContext.save()
    }
    
    func deleteAllExercises() throws {
        do {
            let fetchRequest = Exercise.fetchRequest()
            let objects = try viewContext.fetch(fetchRequest)
            for exercice in objects {
                viewContext.delete(exercice)
            }
            try viewContext.save()
        } catch {
            print("Failed to fetch or delete objects: \(error)")
        }
    }
    
    
}

