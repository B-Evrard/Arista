//
//  AddExerciseViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class AddExerciseViewModel: ObservableObject {
    @Published var type: String = ""
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date()
    @Published var duration: String = ""
    @Published var intensity = 10.0
    
    @Published var showAlert: Bool = false
    @Published var messageAlert: String = ""
    
    
   
    func addExercise() -> Bool {
        do {
            self.showAlert = false
            self.messageAlert = "Selectionner la catégorie"
            if (type.isEmpty)
            {
                self.showAlert = true
                return false
            }
            
            try ExerciseRepository().addExercise(type: type, intensity: String(intensity), startDate: startTime, EndDate: endTime )
            return true
        } catch  {
            self.showAlert = true
            self.messageAlert = error.localizedDescription
            return false
        }
        
    }
    
   
}
