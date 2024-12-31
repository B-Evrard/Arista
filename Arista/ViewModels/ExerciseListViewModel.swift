//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [ExerciseModel]()

    init() {
        fetchExercises()
    }

    private func fetchExercises() {
       
        do {
            let data = ExerciseRepository()
            exercises = try data.getExercise()
            
        } catch {
            
        }
    }
    
    func refreshExercises() {
        fetchExercises()
    }
    
    func deleteExercise() {
        do {
            let data = ExerciseRepository()
            try data.deleteAllExercises()
            fetchExercises()
        } catch {
            
        }
    }
    
    func durationForExercise(_ exercise: Exercise) -> String {
        guard let startDate = exercise.startDate else { return "" }
        guard let endDate = exercise.endDate else { return "" }
        return "\(Int(round(endDate.timeIntervalSince(startDate)/60))) minutes"
    }
}


