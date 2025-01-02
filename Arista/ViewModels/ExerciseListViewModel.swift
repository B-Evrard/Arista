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
            print ("stop")
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
    
}


