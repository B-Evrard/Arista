//
//  AddSleepViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class AddSleepViewModel: ObservableObject {
    
    @Published var sleepModel: SleepModel
    
    @Published var showAlert: Bool = false
    @Published var messageAlert: String = ""
    
    init() {
        self.sleepModel = SleepModel(quality: 1.0,startDate: Date(), endDate: Date())
    }
    
   
    func addSleep() -> Bool {
        do {
            self.showAlert = false
           
            if (sleepModel.startDate >= sleepModel.endDate) {
                self.messageAlert = "Date de début et fin incohérente"
                self.showAlert = true
                return false
            }
            
            try SleepRepository().addSleep(model: sleepModel)
            return true
        } catch  {
            self.showAlert = true
            self.messageAlert = error.localizedDescription
            return false
        }
        
    }
    
}
