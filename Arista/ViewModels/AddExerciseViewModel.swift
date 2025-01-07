//
//  AddExerciseViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class AddExerciseViewModel: ObservableObject {
    
    @Published var exercise: ExerciseModel
    
    @Published var showAlert: Bool = false
    @Published var messageAlert: String = ""
    
    init() {
        self.exercise = ExerciseModel(type: ExerciseType.unknown, intensity: 10.0, startDate: Date(), endDate: Date())
    }
    
   
    func addExercise() -> Bool {
        do {
            self.showAlert = false
           
            if (exercise.type == .unknown)
            {
                self.messageAlert = "Selectionner la catégorie"
                self.showAlert = true
                return false
            }
            
            if (exercise.startDate >= exercise.endDate) {
                self.messageAlert = "Date de début et fin incohérente"
                self.showAlert = true
                return false
            }
            
            try ExerciseRepository().addExercise(model: exercise)
            return true
        } catch  {
            self.showAlert = true
            self.messageAlert = error.localizedDescription
            return false
        }
        
    }
    
}
