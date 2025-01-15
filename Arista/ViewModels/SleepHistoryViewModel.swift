//
//  SleepHistoryViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class SleepHistoryViewModel: ObservableObject {
    @Published var sleepSessions : [SleepModel] = []
    @Published var showError = false
    
    var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.viewContext = context
        fetchSleepSessions()
    }
    
    private func fetchSleepSessions() {
        
        do {
            self.showError = false
            let data = SleepRepository()
            sleepSessions = try data.getSleepSessions().map(toModel(_:))
        } catch {
            self.showError = true
        }
    }
    
    func toModel(_ sleep: Sleep) -> SleepModel {
        return SleepModel(
            quality: Int(sleep.quality),
            startDate: sleep.startDate ?? Date(),
            endDate: sleep.endDate ?? Date()
        )
    }
    
    
}


