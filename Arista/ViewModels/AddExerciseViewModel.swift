//
//  AddExerciseViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class AddExerciseViewModel: ObservableObject {
    @Published var type = ExerciseType.unknown
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date()
    @Published var intensity = 10.0
    
    @Published var showAlert: Bool = false
    @Published var messageAlert: String = ""
    
    
   
    func addExercise() -> Bool {
        do {
            self.showAlert = false
            self.messageAlert = "Selectionner la catégorie"
            if (type == .unknown)
            {
                self.showAlert = true
                return false
            }
            let exerciseModel = ExerciseModel(type: type, intensity: Int(intensity), startDate: startTime, endDate: endTime )
            
            try ExerciseRepository().addExercise(exercise: exerciseModel)
            return true
        } catch  {
            self.showAlert = true
            self.messageAlert = error.localizedDescription
            return false
        }
        
    }
    
   
}
