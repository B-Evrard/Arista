//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [ExerciseModel]()
    @Published var showError = false

    init() {
        fetchExercises()
    }

    private func fetchExercises() {
       
        do {
            self.showError = false
            let data = ExerciseRepository()
            exercises = try data.getExercise()
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
    
}


