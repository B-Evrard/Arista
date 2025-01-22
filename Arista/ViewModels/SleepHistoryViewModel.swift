//
//  SleepHistoryViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class SleepHistoryViewModel: ObservableObject {
    @Published var sleepSessions : [SleepModel] = []
    @Published var showError = false
    
    init(){
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
            quality: Double(sleep.quality),
            startDate: sleep.startDate ?? Date(),
            endDate: sleep.endDate ?? Date()
        )
    }
    
    func refreshSleepSessions() {
        fetchSleepSessions()
    }
}


