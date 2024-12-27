//
//  SleepHistoryViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation

class SleepHistoryViewModel: ObservableObject {
    @Published var sleepSessions : [Sleep] = []
    
    init() {
        fetchSleepSessions()
    }
    
    private func fetchSleepSessions() {
        
        do {
            let data = SleepRepository()
            sleepSessions = try data.getSleepSessions()
            
        } catch {
            
        }
    }
}


