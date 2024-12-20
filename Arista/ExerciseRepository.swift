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
        return try viewContext.fetch (request)
    }
   
   
    func addExercise(type: String, intensity: String, startDate: Date, EndDate: Date) throws {
        let newExercise = Exercise(context: viewContext)
        newExercise.type = type
        newExercise.intensity = intensity
        newExercise.startDate = startDate
        newExercise.endDate = EndDate
        try viewContext.save()
    }
}

