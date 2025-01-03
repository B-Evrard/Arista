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
    
    init() {
        fetchSleepSessions()
    }
    
    private func fetchSleepSessions() {
        
        do {
            self.showError = false
            let data = SleepRepository()
            sleepSessions = try data.getSleepSessions()
        } catch {
            self.showError = true
        }
    }
}


