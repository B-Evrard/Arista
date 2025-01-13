//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [ExerciseModel]()
    @Published var showError = false
    
    var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext){
        self.viewContext = context
        fetchExercises()
    }

    private func fetchExercises() {
       
        do {
            self.showError = false
            let data = ExerciseRepository()
            exercises = try data.getExercise().map(toModel(_:))
        } catch {
            self.showError = true
        }
    }
    
    func refreshExercises() {
        fetchExercises()
    }
    
    func deleteExercise() {
        do {
            self.showError = false
            let data = ExerciseRepository()
            try data.deleteAllExercises()
            fetchExercises()
        } catch {
            self.showError = true
        }
    }
    
    private func toModel(_ exercise: Exercise) -> ExerciseModel {
        return ExerciseModel(
            type: ExerciseType(rawValue: exercise.type ?? "") ,
            intensity: Double(exercise.intensity),
            startDate: exercise.startDate ?? Date(),
            endDate: exercise.endDate ?? Date()
        )
    }
    
    
    
}


